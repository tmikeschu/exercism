const capitalize = s => s.slice(0, 1).toUpperCase() + s.slice(1);

const setFocus = zipper => prop => value =>
  Zipper({
    ...zipper,
    focus: { ...zipper.focus, [prop]: value }
  });

const setters = set =>
  ["left", "right", "value"].reduce(
    (acc, el) => ({ ...acc, [`set${capitalize(el)}`]: set(el) }),
    {}
  );

const dig = zipper => dir =>
  zipper.focus[dir]
    ? Zipper({ focus: zipper.focus[dir], trail: [zipper, dir] })
    : null;

const diggers = dig =>
  ["right", "left"].reduce((acc, el) => ({ ...acc, [el]: () => dig(el) }), {});

const up = ({ trail: [prev, from], focus }) =>
  prev ? Zipper({ ...prev, focus: { ...prev.focus, [from]: focus } }) : null;

const Zipper = zipper => {
  if (!zipper) return null;

  return {
    ...setters(setFocus(zipper)),
    ...diggers(dig(zipper)),
    toTree: () => (zipper.trail[0] ? up(zipper).toTree() : zipper.focus),
    value: () => zipper.focus.value,
    up: () => up(zipper)
  };
};

Zipper.fromTree = x => Zipper({ focus: x, trail: [null, null] });

export default Zipper;
