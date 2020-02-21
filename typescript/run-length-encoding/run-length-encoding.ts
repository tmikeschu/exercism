function encode(input: string): string {
  // any letter or space repeating itself more than once
  const reg = /([A-Za-z ])\1{1,}/g;
  return input.replace(reg, (match, letter) => {
    return `${match.length}${letter}`;
  });
}

function decode(input: string): string {
  // any number preceding a letter or space
  const reg = /(\d+)([A-Za-z ])/g;
  return input.replace(reg, (_match, count, letter) => {
    return letter.repeat(Number(count));
  });
}

export default {
  encode,
  decode
};
