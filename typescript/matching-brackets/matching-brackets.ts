const MATCHES: Record<string, string> = {
  "[": "]",
  "{": "}",
  "(": ")"
};
const OPENED = Object.keys(MATCHES);
const CLOSED = Object.values(MATCHES);

export default class MatchingBrackets {
  private readonly input: string;

  constructor(input: string) {
    this.input = input;
  }

  public isPaired(): boolean {
    const acc: string[] = [];
    for (let i = 0; i < this.input.length; i++) {
      const el = this.input[i];
      if (OPENED.includes(el)) {
        acc.push(el);
      }

      if (CLOSED.includes(el)) {
        const last = acc.pop();
        if (!last || el !== MATCHES[last]) {
          return false;
        }
      }
    }
    return acc.length === 0;
  }
}
