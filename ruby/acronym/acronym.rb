class Acronym
  def self.abbreviate(phrase)
    new(phrase).send(:abbreviate)
  end

  attr_reader :phrase
  def initialize(phrase)
    @phrase = phrase
  end

  def abbreviate
    phrase.
      split(/[,\-\s]/).
      reduce("", &abbreviate_reducer)
  end
  
  def abbreviate_reducer
    -> acc, word { acc + first_upcase(word) }
  end

  def first_upcase(word)
    word[0].to_s.upcase
  end
end
