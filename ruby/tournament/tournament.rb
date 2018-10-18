class Tournament
  CENTER_PADDING = -> x { x.reverse.center(4).reverse }
  PADDINGS = {
    0 => -> x { x.ljust(31) },
    5 => -> x { x.rjust(3) },
  }

  HEADER = %w(Team MP W D L P)

  def self.tally(input)
    new(input).tally
  end

  def tally
    rows.reduce("") { |acc, row| acc + format_row(row) + "\n" }
  end

  private

  attr_reader :input
  def initialize(input)
    @input = input
  end

  def rows
    [HEADER] + team_rows
  end

  def team_rows
    RecordParser.parse(input).
      map { |team, record| [team] + RecordStats.stats(record) }.
      sort_by { |(name, _, _,  _, _, points)| [-points, name] }
  end

  def format_row(row)
    row.
      map.with_index { |v, i| PADDINGS.fetch(i, CENTER_PADDING).call(v.to_s) }.
      join("|")
  end
end

# returns { <team>: ["W", "L", ...] }
class RecordParser
  OUTCOMES = {
    win: %i(W L),
    loss: %i(L W),
    draw: %i(D D),
  }

  def self.parse(input)
    new(input).parse
  end

  def parse
    input.
      split(/[\n;]/).
      each_slice(3).
      reduce({}, &row_reducer)
  end

  private

  attr_reader :input
  def initialize(input)
    @input = input
  end

  def row_reducer
    -> acc, (subject, secondary, outcome) do
      subject_outcome, secondary_outcome = OUTCOMES.fetch(outcome.to_sym)
      acc.merge(
        subject => acc.fetch(subject, []) + [subject_outcome],
        secondary => acc.fetch(secondary, []) + [secondary_outcome]
      )
    end
  end
end

# returns [matches played, winds, draws, losses, points]
class RecordStats
  POINTS = {W: 3, D: 1}

  def self.stats(record)
    new(record).stats
  end

  def stats
    [record.length] + outcomes_count + [total_points]
  end

  private

  attr_reader :record
  def initialize(record)
    @record = record
  end

  def outcomes_count
    %i(W D L).map { |outcome| record.count(outcome) }
  end

  def total_points
    record.sum { |outcome| POINTS.fetch(outcome, 0) }
  end
end
