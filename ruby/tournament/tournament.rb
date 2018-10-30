class Symbol
  def with(*args, &block)
    -> caller, *rest { caller.send(self, *rest, *args, &block) }
  end
end

module Tournament
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
  PIPE     = -> *fns { -> x { fns.reduce(x) { |y, fn| fn.call(y) } } }
  FORMAT   = -> pattern { -> s { format(pattern, s) } }
  LEFT     = FORMAT.call("%-31s")
  CENTER   = PIPE.call(*["%3s", "%-4s"].map(&FORMAT))
  RIGHT    = FORMAT.call("%3s")
  PADDINGS = [ LEFT, *[CENTER] * 4, RIGHT ]

  WITH_OUTCOME = -> ((*teams, outcome)) do
    teams.zip(OUTCOMES.fetch(outcome.to_sym))
  end

  RECORD_REDUCER = -> acc, (team, outcome) do 
    acc.update(team => [outcome]) { |_, old, new| old + new } 
  end

  CALCULATE_COLUMNS = -> team, record do
    COLUMNS.
      map(&:last).
      map(&:call.with(team, record))
  end

  PADDED = -> row do 
    PADDINGS.zip(row).
      map(&:reduce.with(:call)).
      join("|")
  end

  def self.tally(input)
    input.
      split(NEWLINE).
      map(&:split.with(";")).
      flat_map(&WITH_OUTCOME).
      reduce({}, &RECORD_REDUCER).
      map(&CALCULATE_COLUMNS).
      sort_by { |(name, _, _,  _, _, points)| [-points, name] }.
      unshift(COLUMNS.map(&:first)).
      map(&PADDED).
      reduce("") { |acc, row| acc + row + NEWLINE }
  end
end
