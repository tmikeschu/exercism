# Scrabble scores words

class Scrabble
  SCORES = [
    [%i(a e i o u l n r s t), 1],
    [%i(d g), 2],
    [%i(b c m p), 3],
    [%i(f h v w y), 4],
    [%i(k), 5],
    [%i(j x), 8],
    [%i(q z), 10],
  ].freeze

  def self.get_score(letter)
    SCORES.
      select { |(set, _)| set.include?(letter) }.
      map(&:last).
      fetch(0, 0)
  end

  def self.score(word)
    word.
      downcase.
      tr('^a-z', '').
      split('').
      sum { |letter| Scrabble.get_score(letter.to_sym) }
  end

  attr_reader :word
  def initialize(word)
    @word = word
  end

  def score
    Scrabble.score(word || '')
  end
end
