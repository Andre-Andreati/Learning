class Solution:
    def maxEqualRowsAfterFlips(self, matrix: List[List[int]]) -> int:
        def flip(arr): #return flipped array (0->1, 1->0)
            return [int(not x) for x in arr]
        
        def itemInGroups(item, groups): #return if an item is in any of the arrays inside groups
            for group in groups:
                if item in group:
                    return True
            return False
        
        m = len(matrix)
        n = len(matrix[0])
        
        groups = [] #stores groups of rows that are equal or fliped
        for i in range(m):
            if itemInGroups(i, groups): #if the row is already in a group, go to next row
                continue
            test = [matrix[i]] + [flip(matrix[i])] #the row itself and flipped
            group = [i] #starting a group
            for j in range(i+1, m): #check the folloying rows
                if itemInGroups(j, groups): #if the row is already in a group, go to next row
                    continue
                if matrix[j] in test: #if the row is equal to the 'i' row, or flipped, it is in the same group
                    group.append(j)
            groups.append(group)
            
        ans = 0
        for group in groups: #finds the group with most elements
            ans = max(ans, len(group))
        return ans

'''
https://leetcode.com/problems/flip-columns-for-maximum-number-of-equal-rows

You are given an m x n binary matrix matrix.

You can choose any number of columns in the matrix and flip every cell in that column (i.e., Change the value of the cell from 0 to 1 or vice versa).

Return the maximum number of rows that have all values equal after some number of flips.

Example 1:

Input: matrix = [[0,1],[1,1]]
Output: 1
Explanation: After flipping no values, 1 row has all values equal.
Example 2:

Input: matrix = [[0,1],[1,0]]
Output: 2
Explanation: After flipping values in the first column, both rows have equal values.
Example 3:

Input: matrix = [[0,0,0],[0,0,1],[1,1,0]]
Output: 2
Explanation: After flipping values in the first two columns, the last two rows have equal values.

Constraints:

m == matrix.length
n == matrix[i].length
1 <= m, n <= 300
matrix[i][j] is either 0 or 1.
'''