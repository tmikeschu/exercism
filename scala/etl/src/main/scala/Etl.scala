object Etl {
  def transform(letters: Map[Int, Seq[String]]): Map[String, Int] = {
    letters.foldLeft(Map.empty[String, Int]) {
      case (acc, (value, letters)) => {
        acc ++ letters.foldLeft(Map.empty[String, Int]) { case (acc2, letter) =>
          acc2 + (letter.toLowerCase -> value)
        }
      }
    }
  }
}
