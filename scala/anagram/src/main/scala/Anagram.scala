object Anagram {
  private def sameLetters(a: String, b: String): Boolean =
    a.toLowerCase.sorted == b.toLowerCase.sorted

  private def sameWord(a: String, b: String): Boolean =
    a.toLowerCase == b.toLowerCase

  def findAnagrams(word: String, words: List[String]): List[String] =
    words.filter(x => !sameWord(word, x) && sameLetters(word, x))
}
