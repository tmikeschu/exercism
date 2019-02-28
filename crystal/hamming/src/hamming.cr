module Hamming
  def self.compute(a : String, b : String) : Int
    if a.size != b.size
      raise(ArgumentError.new("Strings must be same length"))
    end

    distance = 0
    a.each_char_with_index { |c, i| distance += 1 if c != b[i] }
    distance
  end
end
