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
      flat_map { |(*teams, outcome)| teams.zip(OUTCOMES.fetch(outcome.to_sym)) }.
      reduce({}) { |acc, (team, outcome)| acc.update(team => [outcome]) { |_, old, new| old + new } }.
      map { |team, record| COLUMNS.map { |(_, calculator)| calculator.call(team, record) } }.
      sort_by { |(name, _, _,  _, _, points)| [-points, name] }.
      dup.unshift(COLUMNS.map(&:first)).
      map { |row| row.zip(PADDINGS).
                      map { |(value, padder)| padder.call(value.to_s) }.
                      join("|") }.
      reduce("") { |acc, row| acc + row + NEWLINE }
  end
end
