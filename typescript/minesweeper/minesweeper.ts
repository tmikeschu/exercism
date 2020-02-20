type Board = string[];
type Coordinate = [number, number];
const BOMB = "*";

const NEIGHBORS = [
  [-1, -1],
  [-1, 0],
  [-1, 1],
  [0, -1],
  [0, 1],
  [1, -1],
  [1, 0],
  [1, 1]
];

const neighbors = (xy: Coordinate): Coordinate[] =>
  NEIGHBORS.map(([x, y]) => [x + xy[0], y + xy[1]]);

export default class Minesweeper {
  public annotate = (board: Board): Board => {
    const dig = (x: number, y: number): string | undefined =>
      board[y] && board[y][x];

    const isBomb = ([x, y]: Coordinate): boolean => dig(x, y) === BOMB;

    return board.map((row, y) =>
      row
        .split("")
        .map((cell, x) =>
          cell === BOMB
            ? cell
            : String(neighbors([x, y]).filter(isBomb).length).replace("0", " ")
        )
        .join("")
    );
  };
}
