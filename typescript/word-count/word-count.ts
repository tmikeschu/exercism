export default class Words {
  public count(input: string): Map<string, number> {
    return input
      .trim()
      .replace(/\s+/, " ")
      .toLowerCase()
      .split(" ")
      .reduce((acc, el) => {
        acc.set(el, (acc.get(el) || 0) + 1);
        return acc;
      }, new Map<string, number>());
  }
}
