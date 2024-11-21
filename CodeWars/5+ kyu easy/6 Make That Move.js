function move(s) {
    const findNextP = function(pos) {
      const nextP = s.slice(pos+1).indexOf('p');
      return nextP == -1
        ? 'outRight'
        : pos + nextP + 1;
    }
    const findNextQ = function(pos) {
      const nextQ = s.slice(0, pos).lastIndexOf('q');
      return nextQ == -1
        ? 'outLeft'
        : nextQ;
    }
    const player = {
      position: -1,
      walkingDirection: 1,
      visitedPositions: new Set(),
      walk() {
        this.position += this.walkingDirection;
      },
      jumpRight() {
        this.position = findNextP(this.position);
        this.walkingDirection = 1;
      },
      jumpLeft() {
        this.position = findNextQ(this.position);
        this.walkingDirection = -1;
      }
    }
    player.walk();
    do {
      player.visitedPositions.add(player.position);
      if(player.position >= s.length) return 'p';
      if(player.position < 0) return 'q';
      switch (s[player.position]){
        case '.':
          player.walk();
          break;
        case 'o':
          return 'o';
          break;
        case 'p':
          player.jumpRight();
          if(player.position == 'outRight') return 'p';
          player.walk();
          break;
        case 'q':
          player.jumpLeft();
          if(player.position == 'outLeft') return 'q';
          player.walk();
          break;
      }
    } while (!player.visitedPositions.has(player.position));
    return "x";
  }

/*
https://www.codewars.com/kata/6611b3ccb42a1927e9663bf7

Task
Given a string s portraying a surface like '.......', you start on the left-most edge and face to the right. You continue to move until you either:

exit the surface
end up in an infinite cycle
reach an oracle
Tiles
The surface consists of several tiles:

'.': on a regular surface you continue to walk in your current direction
'o': when reaching an oracle, the simulation ends
jump-points
'p': jump to the next 'p' on the right, face right and walk one tile to the right
'q': jump to the next 'q' on the left, face left and walk one tile to the left
if no other similar jump-point is available in the direction of the current jump-point, exit the surface in that direction
you exit the surface if you jump to a jump-point on the edge of the surface
Output
when reaching an oracle 'o', return 'o'
when you exit the surface to the left, return 'q'
when you exit the surface to the right, return 'p'
when encountering an infinite cycle, return 'x'
Constraints
550 random tests (50 on biggest surfaces)
1 <= size of surface <= 100000
Examples
surface                 | expected result
-----------------------------------------
"....."                   "p"  # walk on surface and exit to the right
"..o.."                   "o"  # walk towards oracle
"p...."                   "p"  # jump beyond the edge of the surface to the right
"q...."                   "q"  # jump beyond the edge of the surface to the left
"....p"                   "p"  # walk and then jump beyond the edge of the surface to the right
"....q"                   "q"  # walk and then jump beyond the edge of the surface to the left
"p..o."                   "p"  # jump over the oracle beyond the edge of the surface to the right
"....p............p...."  "p"  # jump over the next 'p' and exit the surface walking to the right
"....p............p..q."  "q"  # jump over the next 'p' reaching 'q' and jump beyond the edge of the surface to the left
"....p......q.....p..q."  "x"  # jump over the next 'p' reaching 'q', then jump over the other 'q', reaching the initial 'p' again, creating an infinite cycle
"....p...o..q.....p..q."  "o"  # jump over the next 'p' reaching 'q', then jump over the other 'q', and walk towards the oracle
".q..p............p..q."  "q"  # jump beyond the edge of the surface to the left

Sol2:
function move(s) {
  let position = 0;
  let walkingDirection = 1; // 1=right, -1=left
  let visitedPositions = new Set();

  do {
    visitedPositions.add(position);
    if(position >= s.length) return 'p';
    if(position < 0) return 'q';
    switch (s[position]){
      case '.':
        position += walkingDirection; //walks to the current direction
        break;
      case 'o':
        return 'o';
      case 'p':
        walkingDirection = 1;
        do { // walks to the right until find another 'p' or exits the string
          position += walkingDirection;
        } while (s[position] !== 'p' && position < s.length);
        position += walkingDirection;
        break;
      case 'q':
        walkingDirection = -1;
        do { // walks to the left until find another 'q' or exits the string
          position += walkingDirection;
        } while (s[position] !== 'q' && position > -1);
        position += walkingDirection;
        break;
    }
  } while (!visitedPositions.has(position));
  return "x";
}
*/