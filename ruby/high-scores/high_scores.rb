class HighScores
  attr_reader :scores

  def initialize(scores)
    @scores = scores
  end

  def latest
    scores.last
  end

  def personal_best
    scores.max
  end

  def personal_top
    scores.max(3)
  end

  def report
    reports[report_type]
  end

  private

  def report_type
    if personal_best == latest
      :last_best
    else
      :last_and_short
    end
  end

  def reports
    last_score = "Your latest score was #{latest}."
    {
      last_best: "#{last_score} That's your personal best!",
      last_and_short: "#{last_score} That's #{personal_best - latest} short of your personal best!",
    }
  end
end
