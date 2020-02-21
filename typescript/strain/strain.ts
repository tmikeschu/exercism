type Predicate<T> = (x: T) => boolean;
export function keep<T>(xs: T[], pred: Predicate<T>): T[] {
  const result: T[] = [];
  for (const x of xs) {
    if (pred(x)) {
      result.push(x);
    }
  }
  return result;
}

export function discard<T>(xs: T[], pred: Predicate<T>): T[] {
  return keep(xs, (x: T) => !pred(x));
}
