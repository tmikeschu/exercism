class BookStore
  BASE_PRICE = 800
  DISCOUNTS = [0, 0, 0.05, 0.10, 0.20, 0.25]

  def self.calculate_price(basket)
    new(basket).send(:price)
  end

  private

  attr_reader :basket
  def initialize(basket)
    @basket = basket
  end

  def price
    return 0.0 if basket.empty?

    GroupingStrategy.group(basket).
      map(&group_price).
      min
  end

  def group_price
    -> grouping do
      grouping.sum { |group| price_for_count(group.length) / 100.00 }
    end
  end

  def price_for_count(count)
    total = BASE_PRICE * count
    total - total * DISCOUNTS[count]
  end
end

class GroupingStrategy
  # strategies must take an array and return an array of arrays
  # e.g., [Int] -> [[Int]]
  STRATEGIES = %i[zip first_missing]

  def self.group(coll)
    new(coll).send(:group)
  end

  private

  attr_reader :coll
  def initialize(coll)
    @coll = coll
  end

  def group
    STRATEGIES.map { |x| send(x) }
  end

  def zip
    coll.
      group_by(&:itself).
      values.
      sort(&length_sorter(:desc)).
      reduce(&:zip).
      map(&sanitize_group)
  end

  def sanitize_group
    -> group {  [group].flatten.reject(&:nil?) }
  end

  def first_missing
    coll.reduce([[]]) do |acc, el|
      append_group(acc, el).
        sort(&length_sorter(:asc))
    end
  end

  def append_group(acc, el)
    copy        = acc.dup
    index       = index_of_group_without_element(copy, el)
    copy[index] = copy.fetch(index, []).concat([el])
    copy
  end

  def index_of_group_without_element(acc, el)
    acc.find_index { |group|!group.include?(el) } || acc.length
  end

  def length_sorter(direction)
    directions = { asc: 1, desc: -1 }

    -> a, b do
      (a.length <=> b.length) * directions[direction]
    end
  end
end
