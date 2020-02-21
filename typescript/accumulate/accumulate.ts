export default function<T, U = T>(xs: T[], fn: (x: T) => U): U[] {
  const result: U[] = [];
  for (const x of xs) {
    result.push(fn(x));
  }
  return result;
}
