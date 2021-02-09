class School {
  type DB = Map[Int, Seq[String]]

  var _db: DB = Map()

  def add(name: String, g: Int) = {
    _db = _db + (g -> (_db.getOrElse(g, Seq()) :+ name))
  }

  def db: DB = _db

  def grade(g: Int): Seq[String] = _db.get(g).getOrElse(Seq())

  def sorted: DB = _db
    .mapValues(_.sorted)
    .toList
    .sortBy(_._1)
    .toMap
}
