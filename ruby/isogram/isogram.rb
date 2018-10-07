class Isogram
  def self.isogram?(word)
    new(word).send(:isogram?)
  end

  private

  attr_reader :word
  def initialize(word)
    @word = word
  end

  def isogram?
    letters.uniq == letters
  end

  def letters
    word.downcase.scan(/[a-z]/)
  end
end
