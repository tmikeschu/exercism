function validateTriangle(sides: number[]): void {
  const [a, b, c] = sides;
  if (!(sides.every(x => x > 0) && a + b > c && a + c > b && b + c > a)) {
    throw new Error("Side cannot be <= 0");
  }
}

export default class Triangle {
  private sides: number[];

  constructor(...sides: number[]) {
    this.sides = sides;
  }

  kind(): "equilateral" | "isosceles" | "scalene" {
    validateTriangle(this.sides);

    switch (new Set(this.sides).size) {
      case 1:
        return "equilateral";
      case 2:
        return "isosceles";
      default:
        return "scalene";
    }
  }
}
