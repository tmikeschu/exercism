class Luhn
  class << self
    VALIDATORS = %i(valid_length? only_digits? valid_sum?)

    def valid?(raw)
      VALIDATORS.all? { |predicate| send(predicate, raw.tr(" ", "")) }
    end

    private

    def valid_length?(raw)
      raw.length > 1
    end

    def only_digits?(raw)
      !/[^\d^\s]/.===(raw)
    end

    def valid_sum?(raw)
      luhn_sum(raw) % 10 == 0
    end

    def luhn_sum(raw)
      raw.
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
end
