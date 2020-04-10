const COLOR_MAP: Record<string, number> = {
  black: 0,
  brown: 1,
  red: 2,
  orange: 3,
  yellow: 4,
  green: 5,
  blue: 6,
  violet: 7,
  grey: 8,
  white: 9,
};

type Color = keyof typeof COLOR_MAP;

export class ResistorColor {
  private readonly colors: Color[];

  constructor(colors: Color[]) {
    if (colors.length < 2) {
      throw new Error("At least two colors need to be present");
    }
    this.colors = colors;
  }

  value = (): number =>
    Number(
      this.colors
        .slice(0, 2)
        .map((color) => COLOR_MAP[color])
        .join("")
    );
}
