class School {
  type DB = Map[Int, Seq[String]]

  var _db: DB = Map()

  def add(name: String, g: Int) = {
    val update = _db.get(g).map(s => s :+ name).getOrElse(Seq(name))
    _db = _db + (g -> update)
  }

  def db: DB = _db

  def grade(g: Int): Seq[String] = _db.get(g).getOrElse(Seq())

  def sorted: DB = _db.toList
    .map { case (grade, names) => (grade, names.sorted) }
    .sortBy { case (int, _) => int }
    .toMap
}
