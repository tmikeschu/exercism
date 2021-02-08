object Sieve {
  def primes(n: Int): List[Int] = {
    val range = List.range(2, n + 1)

    val multiples = range
      .foldLeft(Set[Int]())((acc, el) => acc ++ List.range(el * 2, n + 1, el))

    range.diff(multiples.toList)
  }
}
