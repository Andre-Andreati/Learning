class Solution:
    #if the number of non-positive numbers is even, all negative numbers can be converted to positive,
    #  So, the result is the sum of all abs numbers.
    #if the number of non-positive numbers is odd, we can convert all but one negative numbers to positive,
    #  We can also convert any positive number to negative,
    #  So, we remove from the matrix the element with the lowest abs value,
    #  The result is the sum of all abs numbers in the remaining matrix minus the removed abs element.
    def maxMatrixSum(self, matrix):
        flat = [item for row in matrix for item in row] #flattens the matrix

        num_of_negatives = sum(item<=0 for item in flat)

        if num_of_negatives % 2 == 0: #if the number of non-positive numbers is even
            return sum(abs(num) for num in flat) #the result is the sum of all abs numbers
        #else, if the number of non-positive numbers is odd
        x = min(abs(num) for num in flat) #removing from the matrix the element with the lowest abs value
        if x in flat:
            flat.remove(x)
        else:
            flat.remove(-1 * x)
        return -1 * x + sum(abs(num) for num in flat) #the result is the sum of all abs numbers in the remaining matrix minus the removed abs element
    
'''
https://leetcode.com/problems/maximum-matrix-sum

You are given an n x n integer matrix. You can do the following operation any number of times:

Choose any two adjacent elements of matrix and multiply each of them by -1.
Two elements are considered adjacent if and only if they share a border.

Your goal is to maximize the summation of the matrix's elements. Return the maximum sum of the matrix's elements using the operation mentioned above.

Example 1:

Input: matrix = [[1,-1],[-1,1]]
Output: 4
Explanation: We can follow the following steps to reach sum equals 4:
- Multiply the 2 elements in the first row by -1.
- Multiply the 2 elements in the first column by -1.
Example 2:

Input: matrix = [[1,2,3],[-1,-2,-3],[1,2,3]]
Output: 16
Explanation: We can follow the following step to reach sum equals 16:
- Multiply the 2 last elements in the second row by -1.

Constraints:

n == matrix.length == matrix[i].length
2 <= n <= 250
-105 <= matrix[i][j] <= 105
'''