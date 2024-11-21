function spiralize (n) {

    let start = []; //for storing the matrix
    for(i=0; i<n; i++) { //filling with zeros
      let row = [];
      for(j=0; j<n; j++) {
        row.push(0);
      }
      start.push(row);
    }

    let point = [0, 0]; //initial point
    start[point[0]][point[1]] = 1; //turn initial point to 'one'
    let moved = true;
    let dir = 0; //0=right, 1=down, 2=left, 3=up

    function next(p, d) { //returns the next point considering the direction. Does NOT check if the point exist or is valid
        switch(d) {
            case 0: //right
                return [p[0], p[1]+1];
            case 1: //down
                return [p[0]+1, p[1]];
            case 2: //left
                return [p[0], p[1]-1];
            case 3: //up
                return [p[0]-1, p[1]];
        }
    }

    function isAllowed(m, p, d) { //check if a point 'p' is valid in a matrix 'm' coming from direction 'd'
        if( p[0] < 0 || p[0] >= n || p[1] < 0 || p[1] >= n ) { //if the point is outside the matrix
            return false;
        } else {
            let fronty = next(p, d);
            let righty = next(p, (d+1)%4);
            let lefty = next(p, (d+3)%4);
            let frontiers = [fronty, righty, lefty]; //the points to the front and sides of 'p', to check if the spiral would touch itself
            for(let f of frontiers) {
                if( m[f[0]] != undefined && m[f[0]][f[1]] == 1 ) { //if one of the 'frontiers' points are '1', the spiral would touch itself
                    return false;
                }
            }
            return true; //if the point is not outside the matrix and the spiral is not touching itself, the point is valid
        }
    }

    function move() { //change the 'start' matrix to the next confirguration. Changes 'p' if a move is allowed. Change dir if move in previous dir is not allowed
        if( isAllowed( start, next(point, dir), dir ) ) { //if a move in the current direction is allowed
            point = next(point, dir); //set the move to be made
        } else { //if a move in the current direction is NOT allowed...
            dir = (dir+1) % 4; //...change the direction - 0->1->2->3->0
            if( isAllowed( start, next(point, dir), dir ) ) { //if a move in the NEW direction is allowed
                point = next(point, dir); //set the move to be made
            } else { //if a move in the *current* direction is NOT allowed, and a move in the *next* direction is also NOT allowed
                moved = false; //no move is executed
                return;
            }
        }
        start[point[0]][point[1]] = 1; //make the move
        moved = true; //a move have been executed
        return;
    }

    while(moved == true) { //while there are moves being executed. Stops when no move can be executed.
        move();
    }
    return start;
}
  
console.log(...spiralize(5))

/*
https://www.codewars.com/kata/534e01fbbb17187c7e0000c6/train/javascript

Your task, is to create a NxN spiral with a given size.

For example, spiral with size 5 should look like this:

00000
....0
000.0
0...0
00000
and with the size 10:

0000000000
.........0
00000000.0
0......0.0
0.0000.0.0
0.0..0.0.0
0.0....0.0
0.000000.0
0........0
0000000000
Return value should contain array of arrays, of 0 and 1, with the first row being composed of 1s. For example for given size 5 result should be:

[[1,1,1,1,1],[0,0,0,0,1],[1,1,1,0,1],[1,0,0,0,1],[1,1,1,1,1]]
Because of the edge-cases for tiny spirals, the size will be at least 5.

General rule-of-a-thumb is, that the snake made with '1' cannot touch to itself.
*/