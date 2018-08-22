var Bob = function() {}

const apply = fn => args => fn.apply(null, args)
const applyTo = x => fn => fn(x)
const defaultTo = def => x => (Boolean(x) ? x : def)
const filter = pred => xs => xs.filter(pred)
const join = del => xs => xs.join(del)
const keys = obj => Object.keys(obj)
const of = x => [x]
const pipe = (...funs) => x => funs.reduce((y, fun) => fun(y), x)
const prepend = x => xs => [x, ...xs]
const propOn = obj => prop => obj[prop]
const sort = xs => xs.sort()
const trim = x => x.trim()
const endsWith = x => s => s.endsWith(x)
const upper = s => s.toUpperCase()
const isUpper = s => upper(s) === s
const test = r => s => r.test(s)
const both = (f, g) => x => f(x) && g(x)
const not = fn => x => !fn(x)

const responses = {
  default: "Whatever.",
  question: "Sure.",
  questionshout: "Calm down, I know what I'm doing!",
  shout: "Whoa, chill out!",
  silence: "Fine. Be that way!"
}

const tests = {
  question: endsWith("?"),
  shout: both(isUpper, test(/[a-z]/i)),
  silence: not(Boolean)
}

Bob.prototype.hey = pipe(
  trim,
  pipe(
    pipe(
      applyTo,
      of,
      prepend(propOn(tests)),
      apply(pipe)
    ),
    filter,
    pipe(
      keys,
      applyTo
    )(tests)
  ),
  sort,
  join(""),
  defaultTo("default"),
  propOn(responses)
)

module.exports = Bob
