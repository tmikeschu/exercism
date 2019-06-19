// formatting
const EMPTY_CELL = "_"
const CELL_SEPARATOR = " "
const NEWLINE = "\n"
const WHITE = "W"
const BLACK = "B"

// utils
const ifElse = (test, ifTrue, ifFalse) => x => test(x) ? ifTrue(x) : ifFalse(x)
const id = x => x
const always = a => () => a
const eq = a => b => a === b
const map = mapper => xs => xs.map(mapper)
const join = del => xs => xs.join(del)
const pipe = (...fns) => x => fns.reduce((y, fn) => fn(y), x)
const concat = a => b => b.concat(a)
const arrsEq = (as, bs) => as.every((a, i) => eq(a)(bs[i]))
const defaultTo = dflt => ifElse(eq(undefined), always(dflt),  id)
const slope = ([x1, y1], [x2, y2]) => Math.abs((y1 - y2) / (x1 - x2))


// model
const initialBoard = [...Array(8)].map(() => [...Array(8)])
const populateBoard = ({ white, black }, board = initialBoard) => {
  return board.map(
    (row, i) => row.map(
      (cell, j) => {
        if (arrsEq([i, j], white)) {
          return WHITE
        } else if (arrsEq([i, j], black)) {
          return BLACK
        }
        return cell
      }
    )
  )
}

export class QueenAttack {
  constructor({ white, black } = { white: [0, 3], black: [7, 3] }) {
    this.validate({ white, black })
    this.white = white
    this.black = black
    this.board = populateBoard({ white, black })
  }

  validate({ white, black }) {
    if (arrsEq(white, black)) {
      throw "Queens cannot share the same space"
    }
  }

  toString() {
    return pipe(
      map(
        pipe(
          map(defaultTo(EMPTY_CELL)),
          join(CELL_SEPARATOR)
        )
      ),
      join(NEWLINE),
      concat(NEWLINE)
    )(this.board)
  }

  canAttack() {
    const  {
      white,
      black,
      white: [wRow, wCol],
      black: [bRow, bCol],
    } = this

    return [
      eq(wRow)(bRow),
      eq(wCol)(bCol),
      eq(1)(slope(white, black))
    ].some(Boolean)
  }
}
