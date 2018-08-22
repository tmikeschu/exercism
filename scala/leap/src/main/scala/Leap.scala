object Leap {
  def leapYear(year: Int): Boolean = {
    val divisible = (x: Int) => (y: Int) => x % y == 0
    val yearDivisible = divisible(year)
    val and = (x: Boolean, y: Boolean) => x && y
    val or = (x: Boolean, y: Boolean) => x || y

    and(
      yearDivisible(4),
      or(!yearDivisible(100), yearDivisible(400))
    )
  }
}
