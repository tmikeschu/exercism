class Tournament
  COLUMNS = [
    ["Team", -> team, record { team }],
    ["MP", -> _, record { record.count }],
    ["W", -> _, record { record.count(:W) }],
    ["D", -> _, record { record.count(:D) }],
    ["L", -> _, record { record.count(:L) }],
    ["P", -> _, record { record.sum { |y| POINTS.fetch(y) } }],
  ]
  NEWLINE  = $/
  OUTCOMES = {win: %i(W L), loss: %i(L W), draw: %i(D D)}
  POINTS   = {W: 3, D: 1, L: 0}
  PADDINGS = [
    -> x { x.ljust(31) },
    *[-> x { x.reverse.center(4).reverse }] * 4,
    -> x { x.rjust(3) },
  ]

  def self.tally(input)
    input.
      split(NEWLINE).
      map { |line| line.split(";") }.
      flat_map(&with_outcome).
      reduce({}, &record_reducer).
      map(&calculate_columns).
      sort_by { |(name, _, _,  _, _, points)| [-points, name] }.
      dup.unshift(COLUMNS.map(&:first)).
      map(&padded) .
      reduce("") { |acc, row| acc + row + NEWLINE }
  end

  def self.with_outcome
    -> ((*teams, outcome)) { teams.zip(OUTCOMES.fetch(outcome.to_sym)) }
  end

  def self.record_reducer
    -> acc, (team, outcome) do 
      acc.update(team => [outcome]) { |_, old, new| old + new } 
    end
  end

  def self.calculate_columns
    -> team, record do
      COLUMNS.map { |(_, calculator)| calculator.call(team, record) }
    end
  end

  def self.padded
    -> row do 
      row.zip(PADDINGS).
        map { |(value, padder)| padder.call(value.to_s) }.
        join("|")
    end
  end
end
