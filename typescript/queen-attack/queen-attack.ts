type Position = [number, number];
type Cell = "_" | "W" | "B";
type Row = [Cell, Cell, Cell, Cell, Cell, Cell, Cell, Cell];
type Board = [Row, Row, Row, Row, Row, Row, Row, Row];

const EMPTY_BOARD = [...Array(8)].map(() => "_".repeat(8).split("")) as Board;
const newBoard = (): Board => {
  return [...EMPTY_BOARD.map(row => [...row])] as Board;
};

function validatePositions(white: Position, black: Position): void {
  if (white[0] === black[0] && white[1] === black[1]) {
    throw new Error("Queens cannot share the same space");
  }
}

export default class QueenAttack {
  public readonly white: Position;
  public readonly black: Position;
  private board: Board;

  constructor({ white, black }: { white: Position; black: Position }) {
    validatePositions(white, black);

    this.white = white;
    this.black = black;
    this.board = this.assignBoard();
  }

  public canAttack(): boolean {
    const {
      white: [wx, wy],
      black: [bx, by]
    } = this;

    const negativeSlope = bx - by === wx - wy;
    const positiveSlope = by + bx === wx + wy;

    return wx === bx || wy === by || negativeSlope || positiveSlope;
  }

  private assignBoard(): Board {
    return newBoard().map((row, y) =>
      row.map((cell, x) =>
        y === this.white[0] && x === this.white[1]
          ? "W"
          : y === this.black[0] && x === this.black[1]
          ? "B"
          : cell
      )
    ) as Board;
  }

  public toString(): string {
    return this.board
      .map(row => row.join(" "))
      .join("\n")
      .concat("\n");
  }
}
