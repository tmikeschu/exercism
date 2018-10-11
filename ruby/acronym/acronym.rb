class Acronym
  def self.abbreviate(phrase)
    new(phrase).send(:abbreviate)
  end

  private

  attr_reader :phrase
  def initialize(phrase)
    @phrase = phrase
  end

  def abbreviate
    phrase.
      split(/[,\-\s]/).
      reduce("") { |acc, word| acc + abbreviate_word(word) }
  end

  def abbreviate_word(word)
    word.
      chars.
      fetch(0, "").
      upcase
  end
end
