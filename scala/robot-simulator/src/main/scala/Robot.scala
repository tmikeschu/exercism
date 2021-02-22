object Bearing extends Enumeration {
  val North, East, South, West = Value
}

class Robot(val bearing: Bearing.Value, val coordinates: Tuple2[Int, Int]) {
  import Bearing._
  import Robot._

  private def nextItem[T](xs: List[T], current: T): T = {
    val index = xs.indexOf(current)
    val (before, after) = xs.splitAt(index + 1)
    List.concat(after, before).head
  }

  def turnRight(): Robot = {
    val newBearing = nextItem(bearings, bearing)
    Robot(newBearing, coordinates)
  }

  def turnLeft(): Robot = {
    val newBearing = nextItem(bearings.reverse, bearing)
    Robot(newBearing, coordinates)
  }

  def simulate(input: String): Robot = {
    input.foldLeft(this)((r, action) => {
      action match {
        case 'L' => r.turnLeft()
        case 'R' => r.turnRight()
        case 'A' => r.advance()
        case _   => r
      }
    })
  }

  def advance(): Robot = {
    val (x, y) = coordinates
    val newCoords = bearing match {
      case North => (x, y + 1)
      case East  => (x + 1, y)
      case South => (x, y - 1)
      case West  => (x - 1, y)
      case _     => (x, y)
    }
    Robot(bearing, newCoords)
  }

  // https://alvinalexander.com/scala/how-to-define-equals-hashcode-methods-in-scala-object-equality/
  def canEqual(a: Any): Boolean = a.isInstanceOf[Robot]
  override def equals(obj: Any): Boolean = {
    obj match {
      case r: Robot => this.canEqual(r) && r.hashCode == this.hashCode
      case _        => false
    }
  }
  override def hashCode: Int = coordinates.hashCode() + bearing.id
}

object Robot {
  import Bearing._
  def apply(bearing: Bearing.Value, coords: Tuple2[Int, Int]): Robot = {
    new Robot(bearing, coords)
  }

  val bearings = List(North, East, South, West)
}
