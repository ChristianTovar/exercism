export const isArmstrongNumber = number => {
  const numberList = number.toString().split('').map(x => Number(x))
  const exp = numberList.length

  if (sum(numberList) === number) {
    return true;
  } else {
    return false;
  }

  function sum(list) {
    return list.reduce((acc, val) => acc + Math.pow(val, exp), 0);
  }
};
