module Hamming
  def self.compute(a : String, b : String) : Int
    if a.size != b.size
      raise(ArgumentError.new("Strings must be same length"))
    end

    a.chars
      .zip(b.chars)
      .count { |(x, y)| x != y }
  end
end
