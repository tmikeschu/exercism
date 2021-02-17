object Etl {
  def transform(scoresLetters: Map[Int, Seq[String]]): Map[String, Int] = {
    scoresLetters.flatMap { case (score, letters) =>
      letters.map(letter => (letter.toLowerCase, score))
    }
  }
}
