function bombHasBeenPlanted(map, time) {
    const findPosition = function(str) {
      for (let i = 0; i < map.length; i++) {
        for (let j = 0; j < map[i].length; j++) {
          if (map[i][j] === str) {
            return [i, j];
          }
        }
      }
    }
    const calculateDistance = function(pos1, pos2) {
      return Math.max(Math.abs(pos1[0] - pos2[0]), Math.abs(pos1[1] - pos2[1]));
    }
    const CT = findPosition('CT');
    const B = findPosition('B');
    const K = findPosition('K');
    if (time >= calculateDistance(CT, B) + 10) {
      return true;
    }
    else if (!K) return false;
    else if (time >= calculateDistance(CT, K) + calculateDistance(K, B) + 5) {
      return true;
    } else return false;
  }

/*
https://www.codewars.com/kata/6621b92d6d4e8800178449f5

Based off the game Counter-Strike

The bomb has been planted and you are the last CT (Counter Terrorist) alive

You need to defuse the bomb in time!

Task:

Given a matrix m and an integer time representing the seconds left before the bomb detonates, determine if it is possible to defuse the bomb in time. The time limit is inclusive.

In the matrix m:

"CT" represents the counter terrorist
"B" represents the bomb
"K" represents the kit
"0" represents empty space
The defuse kit may or may not be present in the matrix

You can defuse the bomb in 2 ways:

If you defuse the bomb without the defuse kit, it will cost 10 seconds
If you defuse the bomb with the defuse kit, it will cost only 5 seconds
Each move the CT makes in any direction costs 1 second

The CT can move diagonally, horizontally and vertically.

Example 1

time = 14

m = 
[
  ["0", "0", "0", "0", "B"],
  ["0", "0", "0", "0", "CT"],
  ["0", "0", "0", "0", "0"],
  ["0", "K", "0", "0", "0"],
]
returns true

Explanation:

The CT moves upwards and gets to the bomb with 13 seconds left

The CT defuses the bomb without a kit which costs 10 seconds

The bomb is succesfully defused

Alternative

The CT picks up the kit which costs 3 seconds

The CT moves to the bomb which costs 3 seconds

The CT defuses with a kit which costs 5 seconds

The bomb is succesfully defused

Example 2

time = 10

m = 
[
  ["CT", "0", "0", "0", "0", "0", "0"],
  [ "0", "0", "0", "0", "0", "0", "0"],
  [ "0", "0", "0", "0", "0", "0", "0"],
  [ "0", "0", "0", "0", "0", "0", "0"],
  [ "0", "0", "0", "0", "0", "0", "0"],
  [ "0", "0", "0", "0", "0", "0", "0"],
  [ "0", "0", "0", "0", "0", "0", "0"],
  [ "0", "0", "0", "0", "0", "0", "B"]
]
returns false

Explanation:

There is no kit present so the CT has to defuse without it

The CT takes 7 seconds to get to the bomb but there are only 10 seconds remaining

The bomb detonates!

Good luck!

Bingo bango bongo bish bash bosh.
*/