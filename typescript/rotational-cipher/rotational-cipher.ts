function rotate(text: string, count: number): string {
  return String.fromCharCode(...text.split("").map(rotateChar(count)));
}

function rotateChar(count: number): (c: string) => number {
  return (c: string): number => {
    if (c.match(/[a-z]/)) {
      return rotateOffset(count, 97, c);
    }
    if (c.match(/[A-Z]/)) {
      return rotateOffset(count, 65, c);
    }
    return c.charCodeAt(0);
  };
}

function rotateOffset(count: number, offset: number, c: string): number {
  return ((c.charCodeAt(0) - offset + count) % 26) + offset;
}

export default {
  rotate
};
