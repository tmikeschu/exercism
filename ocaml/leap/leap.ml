let leap_year y =
  let yearDivBy x = y mod x == 0 in
  yearDivBy 4 && ((not (yearDivBy 100)) || yearDivBy 400)
