let isLeapYear = x => {
  let divisibleBy = a => x mod a === 0;
  divisibleBy(4) && (!divisibleBy(100) || divisibleBy(400));
};
