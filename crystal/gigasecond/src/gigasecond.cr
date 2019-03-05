class Gigasecond
  GIGASECOND = (10 ** 9).seconds

  def self.from(t : Time)
    t + GIGASECOND
  end
end
