function dec(b){
    return [...b].reduce((acc, curr) => acc*2 + 1*curr, 0)
  }
  
  function calculate(num1,num2){
    return dec(num1) + dec(num2)
  }

  /*
  https://www.codewars.com/kata/52ece9de44751a64dc0001d9

  In this kata your task is to create bit calculator. Function arguments are two bit representation of numbers ("101","1","10"...), and you must return their sum in decimal representation.

Test.expect(calculate("10","10") == 4);
Test.expect(calculate("10","0") == 2);
Test.expect(calculate("101","10") == 7);
parseInt and some Math functions are disabled.

Those Math functions are enabled: pow,round,random
*/