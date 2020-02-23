function square(x: number): number {
  return Math.pow(x, 2);
}

function sumRange({
  start = 1,
  stop,
  unitFn = (x: number): number => x,
  sumFn = (x: number): number => x
}: {
  start?: number;
  stop: number;
  unitFn?: (x: number) => number;
  sumFn?: (x: number) => number;
}): number {
  let sum = 0;
  for (let i = start; i <= stop; i++) {
    sum += unitFn(i);
  }
  return sumFn(sum);
}

function squareOfSum(x: number): number {
  return sumRange({ stop: x, sumFn: square });
}

function sumOfSquares(x: number): number {
  return sumRange({ stop: x, unitFn: square });
}

export default class Squares {
  public squareOfSum: number;
  public sumOfSquares: number;
  public difference: number;

  constructor(x: number) {
    this.squareOfSum = squareOfSum(x);
    this.sumOfSquares = sumOfSquares(x);
    this.difference = this.squareOfSum - this.sumOfSquares;
  }
}
