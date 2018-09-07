const dig = (zipper, dir) =>
  zipper.focus[dir]
    ? Zipper({ focus: zipper.focus[dir], trail: [zipper, dir] })
    : null;

const up = ({ trail: [prev, from], focus }) =>
  prev ? Zipper({ ...prev, focus: { ...prev.focus, [from]: focus } }) : null;

const setFocus = (zipper, prop) => value =>
  Zipper({
    ...zipper,
    focus: { ...zipper.focus, [prop]: value }
  });

const Zipper = zipper => {
  if (!zipper) return null;

  return {
    toTree: () => (zipper.trail[0] ? up(zipper).toTree() : zipper.focus),
    left: () => dig(zipper, "left"),
    right: () => dig(zipper, "right"),
    value: () => zipper.focus.value,
    up: () => up(zipper),
    setValue: setFocus(zipper, "value"),
    setLeft: setFocus(zipper, "left"),
    setRight: setFocus(zipper, "right")
  };
};

Zipper.fromTree = x => Zipper({ focus: x, trail: [null, null] });

export default Zipper;
