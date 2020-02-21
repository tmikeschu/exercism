const isEven = (x: number): boolean => x % 2 === 0;

const recurse = (x: number, count: number): number => {
  if (x === 1) {
    return count;
  }

  const whenEven = (): number => x / 2;
  const whenOdd = (): number => 3 * x + 1;
  const next = isEven(x) ? whenEven() : whenOdd();

  return recurse(next, count + 1);
};

class CollatzConjecture {
  static steps(x: number): number {
    if (x <= 0) {
      throw new Error("Only positive numbers are allowed");
    }

    return recurse(x, 0);
  }
}

export default CollatzConjecture;
