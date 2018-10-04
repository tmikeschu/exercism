class Matrix
  attr_reader :raw

  def initialize(raw)
    @raw = raw
  end

  def rows
    raw.lines.map(&to_i_cell)
  end

  def columns
    rows.transpose
  end

  private

  def to_i_cell
    -> row { row.split.map(&:to_i) }
  end
end
