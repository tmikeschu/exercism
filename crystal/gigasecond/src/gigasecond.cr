class Gigasecond
  def self.from(t : Time)
    t + (10 ** 9).seconds
  end
end
