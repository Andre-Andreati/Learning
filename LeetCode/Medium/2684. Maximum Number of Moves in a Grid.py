class Solution:
    def maxMoves(self, grid: list[list[int]]) -> int:
        #for each col, calculate all possible cells in the next col.
        #repeat until no more cell can be walked in.
        
        def possibleNext(i, j): #return the next possible cells from i,j
            if j >= n - 1: #if already the rightmost cell, no more moves
                return []
            start = grid[i][j]
            possible = []
            if i > 0 and grid[i - 1][j + 1] > start:
                possible.append((i - 1, j + 1))
            if grid[i][j + 1] > start:
                possible.append((i, j + 1))
            if i < m - 1 and grid[i + 1][j + 1] > start:
                possible.append((i + 1, j + 1))
            return possible
        
        m = len(grid)
        n = len(grid[0])
        
        possible = [(i, 0) for i in range(m)] #can start from any row in first col
        
        walk = 0
        while possible:
            next_possible_col = []
            for poss in possible: #for each cell in current col,
                next_possible_col.extend(possibleNext(poss[0], poss[1])) #find the possible next cells
            possible = list(set(next_possible_col)) #remove duplicates and update 'possible' list
            if possible:
                walk += 1
        
        return walk
                
test = Solution()
print(test.maxMoves(grid = [[2,4,3,5],[5,4,9,3],[3,4,2,11],[10,9,13,15]]))