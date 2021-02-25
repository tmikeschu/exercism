object SecretHandshake {
  type Move = String
  type Handshake = List[String]

  private val moves: List[(Int, Move)] = List(
    (1, "wink"),
    (10, "double blink"),
    (100, "close your eyes"),
    (1000, "jump"),
    (10000, "reverse")
  )

  def commands(x: Int): Handshake = commandsRecur(
    Integer.parseInt(x.toBinaryString),
    List.empty[String],
    prepend
  )

  private val prepend = (move: Move, handshake: Handshake) => move +: handshake
  private val append = (move: Move, handshake: Handshake) => handshake :+ move

  private def commandsRecur(
      x: Int,
      handshake: Handshake,
      addMove: (Move, Handshake) => Handshake
  ): Handshake = {
    moves
      .takeWhile { case (k, _) => k <= x }
      .lastOption
      .map {
        case (y, move) => {
          val z = x - y
          move match {
            case "reverse" => commandsRecur(z, handshake, append)
            case _         => commandsRecur(z, addMove(move, handshake), addMove)
          }
        }
      }
      .getOrElse(handshake)
  }
}
