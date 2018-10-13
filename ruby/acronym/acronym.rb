# Acronym takes strings of words and makes capitalized acronyms.

class Acronym
  def self.abbreviate(phrase)
    phrase.
      scan(/\b\w/).
      join.
      upcase
  end
end
