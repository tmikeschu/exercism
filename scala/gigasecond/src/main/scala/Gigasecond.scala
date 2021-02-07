import java.time.{LocalDate, LocalDateTime, LocalTime, Duration}
import java.time.temporal.ChronoUnit
import scala.util.chaining._

object Gigasecond {
  val gigasecond: Long =
    Duration.of(math.pow(10, 9).toLong, ChronoUnit.SECONDS).toMillis() / 1000

  def add(startDate: LocalDate): LocalDateTime = (
    startDate.atStartOfDay().pipe(add)
  )

  def add(startDateTime: LocalDateTime): LocalDateTime =
    startDateTime
      .plusSeconds(gigasecond)
}
