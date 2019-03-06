class Sieve
  getter limit : Int32
  getter range : Array(Int32)
  getter sieve : Set(Int32)

  def initialize(@limit)
    @range = (1..limit).to_a

    @sieve = range[1..-1]
      .flat_map { |x| (2 * x..limit).select { |y| y % x == 0 } }
      .to_set
  end

  def primes
    range.reject { |x| sieve.includes?(x) }
  end
end
