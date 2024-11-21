function score( dice ) {
    let qtt = {
      1: 0,
      2: 0,
      3: 0,
      4: 0,
      5: 0,
      6: 0
    };
    dice.forEach((item) => {
      qtt[item]++;
    });
    let score = 0;
    for (const face in qtt) {
      switch (face) {
        case '1':
          switch (qtt[face]) {
            case 1:
            case 2:
              score += 100 * qtt[face];
              break;
            case 3:
              score += 1000;
              break;
            case 4:
            case 5:
              score += 1000 + (100 * (qtt[face] - 3))
              break;
          }
          break;
        case '2':
          qtt[face] >= 3 ? score += 200 : score += 0;
          break;
        case '3':
          qtt[face] >= 3 ? score += 300 : score += 0;
          break;
        case '4':
          qtt[face] >= 3 ? score += 400 : score += 0;
          break;
        case '5':
          switch (qtt[face]) {
            case 1:
            case 2:
              score += 50 * qtt[face];
              break;
            case 3:
              score += 500;
              break;
            case 4:
            case 5:
              score += 500 + (50 * (qtt[face] - 3))
              break;
          }
          break;
        case '6':
          qtt[face] >= 3 ? score += 600 : score += 0;
          break;
      }
    }
    return score;
  }

/*
https://www.codewars.com/kata/5270d0d18625160ada0000e4

Greed is a dice game played with five six-sided dice. Your mission, should you choose to accept it, is to score a throw according to these rules. You will always be given an array with five six-sided dice values.

 Three 1's => 1000 points
 Three 6's =>  600 points
 Three 5's =>  500 points
 Three 4's =>  400 points
 Three 3's =>  300 points
 Three 2's =>  200 points
 One   1   =>  100 points
 One   5   =>   50 point
A single die can only be counted once in each roll. For example, a given "5" can only count as part of a triplet (contributing to the 500 points) or as a single 50 points, but not both in the same roll.

Example scoring

 Throw       Score
 ---------   ------------------
 5 1 3 4 1   250:  50 (for the 5) + 2 * 100 (for the 1s)
 1 1 1 3 1   1100: 1000 (for three 1s) + 100 (for the other 1)
 2 4 4 5 4   450:  400 (for three 4s) + 50 (for the 5)
Note: your solution must not modify the input list.
*/