type List<T> = T[] | Array<List<T>>;

function flatten<T = number>(xs: List<T>): T[] {
  const result: T[] = [];
  for (const x of xs) {
    if (Array.isArray(x)) {
      result.push(...flatten(x));
    } else if (x !== undefined) {
      result.push(x);
    }
  }
  return result;
}

export default {
  flatten
};
