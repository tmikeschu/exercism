object Bob {
  def response(statement: String): String = {
    val responses = Map(
      Set("question", "shout") -> "Calm down, I know what I'm doing!",
      Set("question") -> "Sure.",
      Set("shout") -> "Whoa, chill out!",
      Set("silence") -> "Fine. Be that way!",
      Set() -> "Whatever."
    )

    (responses compose cases)(statement)
  }

  private def cases(s: String): Set[String] = {
    val hasLetters = (s: String) => !"[a-zA-Z]+".r.findFirstIn(s).isEmpty

    (Map(
      "silence" -> ((x: String) => x == ""),
      "shout" -> ((x: String) => x.toUpperCase == x && hasLetters(x)),
      "question" -> ((x: String) => x.endsWith("?"))
    ) filter { case (_, v) => v(s.trim) } keys).toSet
  }
}
