object EarthOrbitalRatio extends Enumeration {
  val Mercury = 0.2408467
  val Venus = 0.61519726
  val Earth = 1.0
  val Mars = 1.8808158
  val Jupiter = 11.862615
  val Saturn = 29.447498
  val Uranus = 84.016846
  val Neptune = 164.7913
}

object SpaceAge {
  private val earthYearSeconds: Double = 31557600

  private val adjust = (ratio: Double) =>
    (seconds: Double) => {
      onEarth(seconds / ratio)
    }

  def onEarth(seconds: Double): Double = seconds / earthYearSeconds

  def onMercury = adjust(EarthOrbitalRatio.Mercury)

  def onVenus = adjust(EarthOrbitalRatio.Venus)

  def onMars = adjust(EarthOrbitalRatio.Mars)

  def onJupiter = adjust(EarthOrbitalRatio.Jupiter)

  def onSaturn = adjust(EarthOrbitalRatio.Saturn)

  def onUranus = adjust(EarthOrbitalRatio.Uranus)

  def onNeptune = adjust(EarthOrbitalRatio.Neptune)
}
