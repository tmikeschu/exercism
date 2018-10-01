class Matrix
  attr_reader :raw

  def initialize(raw)
    @raw = raw
  end

  def rows
    raw.lines.map(&to_i_cell)
  end

  def columns
    first_row.zip(*tail_rows)
  end

  private

  def to_i_cell
    -> row { row.split.map(&:to_i) }
  end

  def first_row
    rows.fetch(0, [])
  end

  def tail_rows
    rows.drop(1)
  end
end
