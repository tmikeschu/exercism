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
    letters.uniq.length == letters.length
  end

  def letters
    word.
      downcase.
      tr("^a-z", "").
      chars
  end
end
