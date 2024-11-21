function countColTriang(pointsList) { 
  
    function determinant(m) { //input: matrix of any size ; output: determinant of the matrix
      if(m.length == 1) return m[0][0];
      if(m.length == 2) return m[0][0] * m[1][1] - m[0][1] * m[1][0];
      return m[0].reduce((acum, item, index) => {
        const sign = index % 2 == 0 ? 1 : -1;
        const smallerMatrix = m.slice(1).map(row => row.slice(0,index).concat(row.slice(index+1))); // removes first row and collumn 'i'
        return acum + sign * item * determinant(smallerMatrix);
      }, 0);
    };
  
    function isAligned(trio) { //input: array of 3 points ([x1,y1],[x2,y2],[x3,y3]) ; output: true if they are aligned, false otherwise
      return determinant(trio.map((point) => point.concat(1))) == 0 ? true : false;
    }
    
    function listPossibleTriangles(arr) { //input: array of points ; output: array of arrays of 3 points that form triangles (are not aligned)
      let ans = [];
      arr.forEach((point, i) => {
        arr.slice(i+1).forEach((point2, j) => {
          arr.slice(i+1).slice(j+1).forEach((point3) => {
            if (!isAligned([point, point2, point3])) ans.push([point, point2, point3]);
          })
        })
      })
      return ans;
    }
  
    function listPossibleTrianglesByColor(obj) { //input: object with keys as colors and values as arrays of points ; output: object with keys as colors and values as array of arrays of 3 points that form triangles
      let ans = {};
      for (const color in obj) {
        ans[color] = listPossibleTriangles(obj[color]);
      }
      return ans;
    }
  
    function countTrianglesByColor(obj) { //input: object with keys as colors and values as arrays of arrays of 3 points that form triangles ; output: object with keys as colors and values as number of triangles
      let ans = {};
      for (const color in obj) {
        ans[color] = obj[color].length;
      }
      return ans;
    }
    
    let totalGivenPoints = pointsList.length; // answer [1]
    let colors = [... new Set(pointsList.map((item) => item[1]))] // list of unique colors
    let totalGivenColours = colors.length; // answer [2]
    let points = {};
    colors.forEach((color) => {
      points[color] = pointsList.filter((item) => item[1] == color).map((item) => item[0]);
    })
  
    let trianglesByColor = countTrianglesByColor(listPossibleTrianglesByColor(points));
  
    let totalTriangles = 0;
    for (const color in trianglesByColor) {
      totalTriangles += trianglesByColor[color]; //answer[3]
    }
    
    let trianglesByColorArray = Object.entries(trianglesByColor).sort().sort((prev, next) => next[1] - prev[1]); //rearrange the trianglesByColor object in descending order of number of triangles and alphabetically
  
    function findAnswer4and5(arr) { //organizing in the output format
      let ans = [] 
      if (arr[0][1] == 0) return ans;
      for (let i = 0; i < arr.length; i++) {
        if (arr[i][1] == arr[0][1]) ans.push(arr[i][0]);
      }
      ans.push(arr[0][1]);
      return ans
    }
    let answer4and5 = findAnswer4and5(trianglesByColorArray); //answer[4 and 5]
    
    return [totalGivenPoints, totalGivenColours, totalTriangles, answer4and5];
  }

  /*
  https://www.codewars.com/kata/57cebf1472f98327760003cd

  You have the following lattice points with their corresponding coordinates and each one with an specific colour.

Point   [x ,  y]     Colour
----------------------------
 A     [ 3, -4]     Blue
 B     [-7, -1]     Red
 C     [ 7, -6]     Yellow
 D     [ 2,  5]     Yellow
 E     [ 1, -5]     Red
 F     [-1,  4]     Red
 G     [ 1,  7]     Red
 H     [-3,  5]     Red
 I     [-3, -5]     Blue
 J     [ 4,  1]     Blue
We want to count the triangles that have the three vertices with the same colour. The following picture shows the distribution of the points in the plane with the required triangles.

source: imgur.com

The input that we will have for the field of lattice points described above is:

[[[3, -4], "blue"],  [[-7, -1], "red"], [[7, -6], "yellow"], [[2, 5], "yellow"],
 [[1, -5], "red"],   [[-1, 4], "red"],  [[1, 7], "red"],     [[-3, 5], "red"], 
 [[-3, -5], "blue"], [[4, 1], "blue"] ]
We see the following result from it:

Colour   Amount of Triangles       Triangles
Yellow         0                    -------
Blue           1                      AIJ
Red            10                   BEF,BEG,BEH,BFG,BFH,BGH,EFG,EFH,EHG,FGH
As we have 5 different points in red and each combination of 3 points that are not aligned.

We need a code that may give us the following information in order:

1) Total given points
2) Total number of colours
3) Total number of possible triangles
4) and 5) The colour (or colours, sorted alphabetically) with the highest amount of triangles
In Python our function will work like:

[10, 3, 11, ["red",10]]) == count_col_triang([[[3, -4], "blue"],  [[-7, -1], "red"], [[7, -6], "yellow"], [[2, 5], "yellow"], 
                                              [[1, -5], "red"],   [[-1, 4], "red"],  [[1, 7], "red"],     [[-3, 5], "red"],
                                              [[-3, -5], "blue"], [[4, 1], "blue"] ])
In the following case we have some points that are aligned and we have less triangles that can be formed:

[10, 3, 7, ["red", 6]] == count_col_triang([[[3, -4], "blue"],  [[-7, -1], "red"], [[7, -6], "yellow"], [[2, 5], "yellow"],
                                            [[1, -5], "red"],   [[1, 1], "red"],   [[1, 7], "red"],     [[1, 4], "red"], 
                                            [[-3, -5], "blue"], [[4, 1], "blue"] ])
Just to see the change with the previous case we have this:

source: imgur.com

In the special case that the list of points does not generate an even single triangle, the output will be like this case:

[9, 3, 0, []] == count_col_triang([[[1, -2], "red"], [[7, -6], "yellow"], [[2, 5], "yellow"], [[1, -5], "red"],
                                  [[1, 1], "red"],   [[1, 7], "red"],     [[1, 4], "red"],    [[-3, -5], "blue"], 
                                  [[4, 1], "blue"] ])
It will be this case:

source: imgur.com

If in the result we have two or more colours with the same maximum amount of triangles, the last list should be like (e.g)

[35, 6, 35, ["blue", "red", "yellow", 23]]     # having the names of the colours sorted alphabetically
For the condition of three algined points A, B, C, you should know that the the following determinant should be 0.

 | xA    yA    1|
 | xB    yB    1|    = 0
 | xC    yC    1|
Assumptions:

In the list you have unique points, so a point can have only one colour.

All the inputs are valid

Enjoy it!
  */