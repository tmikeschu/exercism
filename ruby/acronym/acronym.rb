class Acronym
  def self.abbreviate(phrase)
    phrase.split(/[,\-\s]/).reduce("") do |acc, word|
      acc.concat(word.chars.fetch(0, "").upcase)
    end
  end
end
