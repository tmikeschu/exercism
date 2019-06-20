// formatting
const EMPTY_CELL = "_";
const CELL_SEPARATOR = " ";
const NEWLINE = "\n";
const WHITE = "W";
const BLACK = "B";

const Utils = {
  id: x => x,
  always: a => () => a,
  eq: a => b => a === b,
  map: mapper => xs => xs.map(mapper),
  join: del => xs => xs.join(del),
  pipe: (...fns) => x => fns.reduce((y, fn) => fn(y), x),
  concat: a => b => b.concat(a),
  arrsEq: (as, bs) => as.every((a, i) => Utils.eq(a)(bs[i])),
  defaultTo: dflt =>
    Utils.ifElse(Utils.eq(undefined), Utils.always(dflt), Utils.id),
  slope: ([x1, y1], [x2, y2]) => Math.abs((y1 - y2) / (x1 - x2)),
  ifElse: (test, ifTrue, ifFalse) => x => (test(x) ? ifTrue(x) : ifFalse(x))
};

// model
const initialBoard = [...Array(8)].map(() => [...Array(8)]);
const populateBoard = ({ white, black }, board = initialBoard) => {
  const { arrsEq } = Utils;

  return board.map((row, i) =>
    row.map((cell, j) => {
      const current = [i, j];

      if (arrsEq(current, white)) {
        return WHITE;
      } else if (arrsEq(current, black)) {
        return BLACK;
      }
      return cell;
    })
  );
};

export class QueenAttack {
  constructor({ white, black } = { white: [0, 3], black: [7, 3] }) {
    this.validate({ white, black });
    this.white = white;
    this.black = black;
    this.board = populateBoard({ white, black });
  }

  validate({ white, black }) {
    if (Utils.arrsEq(white, black)) {
      throw "Queens cannot share the same space";
    }
  }

  toString() {
    const { map, pipe, join, defaultTo, concat } = Utils;

    return pipe(
      map(
        pipe(
          map(defaultTo(EMPTY_CELL)),
          join(CELL_SEPARATOR)
        )
      ),
      join(NEWLINE),
      concat(NEWLINE)
    )(this.board);
  }

  canAttack() {
    const { eq, slope } = Utils;
    const {
      white,
      black,
      white: [wRow, wCol],
      black: [bRow, bCol]
    } = this;

    return [wRow / bRow, wCol / bCol, slope(white, black)].some(eq(1));
  }
}
