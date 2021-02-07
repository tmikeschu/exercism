object DifferenceOfSquares {

  val sumOfSquares: Int => Int = n =>
    List
      .range(1, n + 1)
      .map(math.pow(_, 2))
      .sum
      .toInt

  val squareOfSum: Int => Int = (n) => {
    val sum = List.range(1, n + 1).sum
    math.pow(sum, 2).toInt
  }

  def differenceOfSquares(n: Int): Int =
    List(squareOfSum, sumOfSquares)
      .map(_(n))
      .reduce(_ - _)
}
