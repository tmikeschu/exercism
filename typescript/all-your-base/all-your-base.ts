function to10(base: number, digits: number[]): number[] {
  return digits
    .map((digit, i) => digit * Math.pow(base, digits.length - (i + 1)))
    .reduce((a, b) => a + b, 0)
    .toString()
    .split("")
    .map(Number);
}

function divRem(dividend: number, divisor: number): [number, number] {
  const quotient = Math.floor(dividend / divisor);
  const rem = dividend % divisor;
  return [quotient, rem];
}

function from10(base: number, digits: number[]): number[] {
  let x = Number(digits.join(""));
  const result: number[] = [];
  while (x > 0) {
    const [quotient, remainder] = divRem(x, base);
    result.unshift(remainder);
    x = quotient;
  }
  return result;
}

export default class Converter {
  public convert(digits: number[], fromBase: number, toBase: number): number[] {
    this.validate(digits, fromBase, toBase);

    if (digits.length === 1 && digits[0] === 0) {
      return [0];
    }

    if (fromBase === 10) {
      return from10(toBase, digits);
    }

    if (toBase === 10) {
      return to10(fromBase, digits);
    }

    return from10(toBase, to10(fromBase, digits));
  }

  private validBase(base: number): boolean {
    return base < 2 || Math.floor(base) !== base;
  }

  private validate(digits: number[], fromBase: number, toBase: number): void {
    if (this.validBase(fromBase)) {
      throw new Error("Wrong input base");
    }

    if (this.validBase(toBase)) {
      throw new Error("Wrong output base");
    }

    if (
      digits.length < 1 ||
      (digits.length > 1 && digits[0] === 0) ||
      !digits.every(x => x >= 0 && x < fromBase)
    ) {
      throw new Error("Input has wrong format");
    }
  }
}
