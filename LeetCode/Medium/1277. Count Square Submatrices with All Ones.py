class Solution:
    def countSquares(self, matrix: List[List[int]]) -> int:
        def all_ones(i, j, size): #return true if all elements are one in a submatrix
                                  # starting (top left) at i,j with size x size elems
            if i + size > m or j + size > n:
                return False #if the submatrix would extrapolate the matrix size
            for k in range(i, i + size):
                for l in range(j, j + size):
                    if not matrix[k][l]: #if any element is zero
                        return False
            return True #if no element is zero, all are ones
        
        m = len(matrix)
        n = len(matrix[0])
        count = 0
        
        for i in range(m):
            for j in range(n):
                size = 1
                curr = [i, j, size]
                while all_ones(*curr):
                    count += 1
                    curr[2] += 1 #
                    
        return count
    
'''
https://leetcode.com/problems/count-square-submatrices-with-all-ones

Given a m * n matrix of ones and zeros, return how many square submatrices have all ones.

Example 1:

Input: matrix =
[
  [0,1,1,1],
  [1,1,1,1],
  [0,1,1,1]
]
Output: 15
Explanation: 
There are 10 squares of side 1.
There are 4 squares of side 2.
There is  1 square of side 3.
Total number of squares = 10 + 4 + 1 = 15.
Example 2:

Input: matrix = 
[
  [1,0,1],
  [1,1,0],
  [1,1,0]
]
Output: 7
Explanation: 
There are 6 squares of side 1.  
There is 1 square of side 2. 
Total number of squares = 6 + 1 = 7.

Constraints:

1 <= arr.length <= 300
1 <= arr[0].length <= 300
0 <= arr[i][j] <= 1
'''