function bouncyRatio(ratio) {
    const isBouncy = function(num) {
      const numArr = num.toString().split('');
      if ([...numArr].sort().toString()==numArr.toString() || [...[...numArr].sort()].reverse().toString()==numArr.toString()) return false;
      else return true;
    }
    let ans=0;
    let bouncy=0;
    let total=0;
    do {
      ans++;
      if (isBouncy(ans)) bouncy++;
      total++;
    } while (bouncy/total<ratio);
    return ans;
  }

/*
https://www.codewars.com/kata/562b099becfe844f3800000a

Working from left-to-right if no digit is exceeded by the digit to its left it is called an increasing number; for example, 134468.

Similarly if no digit is exceeded by the digit to its right it is called a decreasing number; for example, 66420.

We shall call a positive integer that is neither increasing nor decreasing a "bouncy" number; for example, 155349.

Clearly there cannot be any bouncy numbers below one-hundred, but just over half of the numbers below one-thousand (525) are bouncy. In fact, the least number for which the proportion of bouncy numbers first reaches 50% is 538.

Surprisingly, bouncy numbers become more and more common and by the time we reach 21780 the proportion of bouncy numbers is equal to 90%.

Your Task
Complete the bouncyRatio function.

The input will be the target ratio.

The output should be the smallest number such that the proportion of bouncy numbers reaches the target ratio.

You should throw an Error for a ratio less than 0% or greater than 99%.

Source

https://projecteuler.net/problem=112
Updates

26/10/2015: Added a higher precision test case.
*/