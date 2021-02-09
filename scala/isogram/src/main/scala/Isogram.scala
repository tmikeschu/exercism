object Isogram {
  def isIsogram(x: String): Boolean = {
    val letters = x.replaceAll("\\W", "").toLowerCase
    letters.toSet.size == letters.length
  }
}
