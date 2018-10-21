// fn utils
const pipe = (...fns) => x => fns.reduce((y, fn) => fn(y), x);
const pair = (a, b) => [a, b];

// list utils
const join = a => xs => xs.join(a);
const split = a => xs => xs.split(a);
const map = fn => xs => xs.map(fn);
const zipWith = fn => ys => xs => xs.map((x, i) => fn(x, ys[i % ys.length]));

// math utils
const subtract = b => a => a - b;
const add = a => b => a + b;
const mod = m => a => a % m;

// letter utils
const toLetter = a => String.fromCharCode(a);
const LETTERS = [...Array(26)].map((_, i) => toLetter(i + 97));
const isOnlyLower = x => new RegExp(/^[a-z]+$/).test(x);
const letterIndex = letter => LETTERS.indexOf(letter);
const randomLetterIndex = () => Math.floor(Math.random() * 25);

const randomKey = () =>
  [...Array(100)].reduce((acc, _) => acc + LETTERS[randomLetterIndex()], "");

const toAscii = pipe(
  mod(26),
  add(97)
);

const shift = key => shifter =>
  pipe(
    split(""),
    zipWith((x, y) => [x, y].map(letterIndex))(key),
    map(
      pipe(
        shifter,
        toAscii,
        toLetter
      )
    ),
    join("")
  );

export function Cipher(key = randomKey()) {
  if (isOnlyLower(key)) {
    Object.assign(this, { key, shift: shift(key.split("")) });
  } else {
    throw new Error("Bad key");
  }
}

Object.assign(Cipher.prototype, {
  encode(input) {
    return this.shift(([x, y]) => x + y)(input);
  },
  decode(input) {
    return this.shift(([x, y]) => x - y + 26)(input);
  }
});
