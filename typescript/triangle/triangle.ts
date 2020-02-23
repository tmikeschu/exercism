function validTriangle(sides: number[]): boolean {
  const [a, b, c] = sides;
  return sides.every(x => x > 0) && a + b > c && a + c > b && b + c > a;
}

export default class Triangle {
  private sides: number[];

  constructor(...sides: number[]) {
    this.sides = sides;
  }

  kind(): "equilateral" | "isosceles" | "scalene" {
    if (!validTriangle(this.sides)) {
      throw new Error("Side cannot be <= 0");
    }

    if (new Set(this.sides).size === 1) {
      return "equilateral";
    }

    if (new Set(this.sides).size === 2) {
      return "isosceles";
    }

    return "scalene";
  }
}
