export const score = (x, y) => {
  const targetRadius = Math.sqrt(x * x + y * y)

  if (targetRadius > 10) {
    return 0;
  } else if (targetRadius <= 10 && targetRadius > 5) {
    return 1;
  } else if (targetRadius <= 5 && targetRadius > 1) {
    return 5;
  } else {
    return 10;
  }
};
