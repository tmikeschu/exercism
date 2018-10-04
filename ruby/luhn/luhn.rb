class Luhn
  def self.valid?(raw)
    new(raw).valid?
  end

  def valid?
    valid_length? && only_digits? && valid_sum?
  end

  private

  attr_reader :sanitized
  def initialize(raw)
    @sanitized = raw.tr(" ", "")
  end

  def valid_length?
    sanitized.length > 1
  end

  def only_digits?
    !/[^\d]/.===(sanitized)
  end

  def valid_sum?
    (luhn_sum % 10).zero?
  end

  def luhn_sum
    sanitized.
      chars.
      reverse.
      map.with_index(&luhn_value).
      sum(&luhn_doubled)
  end

  def luhn_value
    -> x, index { x.to_i * (index % 2 + 1) }
  end

  def luhn_doubled
    -> x { x - (9 * (x / 10)) }
  end
end
