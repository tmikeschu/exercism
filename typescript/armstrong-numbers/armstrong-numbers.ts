function toDigits(x: number): number[] {
  return x
    .toString()
    .split("")
    .map(Number);
}

function isArmstrongNumber(x: number): boolean {
  const digits = toDigits(x);
  const length = digits.length;
  const result = digits.reduce((acc, el) => {
    acc += Math.pow(el, length);
    return acc;
  }, 0);

  return x === result;
}

export default {
  isArmstrongNumber
};
