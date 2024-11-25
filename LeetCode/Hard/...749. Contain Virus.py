class Solution:
    def containVirus(self, isInfected: list[list[int]]) -> int:
        def adjacent(i, j):
            if i == 0:
                if j == 0:
                    return [(0, 1),(1, 0)]
                elif j == n - 1:
                    return [(0, j - 1),(1, j)]
                else:
                    return [(0, j - 1), (0, j + 1), (1, j)]
            elif i == m - 1:
                if j == 0:
                    return [(i, 1),(i - 1, 0)]
                elif j == n - 1:
                    return [(i, j - 1),(i - 1, j)]
                else:
                    return [(i, j - 1), (i, j + 1), (i - 1, j)]
            else:
                if j == 0:
                    return [(i, 1),(i - 1, 0), (i + 1, 0)]
                elif j == n - 1:
                    return [(i, j - 1),(i - 1, j), (i + 1, j)]
                else:
                    return [(i, j - 1), (i, j + 1), (i - 1, j), (i + 1, j)]
                
        def find_frontiers(grid, group):
            frontiers = []
            walls = 0
            for cell in group['cells']:
                adj = adjacent(*cell)
                for a in adj:
                    if not grid[a[0]][a[1]]:
                        walls += 1
                        if a not in frontiers:
                            frontiers.append(a)
            return frontiers, walls
        
        def find_groups(grid):
            groups = {}
            g = 0
            for i in range(m):
                for j in range(n):
                    if grid[i][j]:
                        adj = adjacent(i, j)
                        added = False
                        for a in adj:
                            for idx, group in groups.items():
                                if a in group['cells']:
                                    group['cells'].append((i, j))
                                    added = True
                                    break
                            if added:
                                break
                        if not added:
                            groups[g] = {'cells': [(i, j)]}
                            g += 1
            for group in groups.values():
                group['frontiers'], group['walls'] = find_frontiers(grid, group)
            return groups
        
        m = len(isInfected)
        n = len(isInfected[0])
        g = 0 #for controlling the groups numbers

        #groups = find_groups(isInfected)

        #print('groups: ', groups, '\n')
        
        grid = {}
        for i in range(m):
            for j in range(n):
                grid[(i, j)] = {'infected': isInfected[i][j],
                                'adjacent': adjacent(i, j),
                                'group': None,
                                'status': 'open'}
        
        def group_cells(grid):
            for idx, cell in grid.items():
                if cell['status'] == 'closed':
                    continue
                if cell['infected']:
                    added_to_group = False
                    for adj in cell['adjacent']:
                        if grid[adj]['infected']:
                            if grid[adj]['group'] != None:
                                cell['group'] = grid[adj]['group']
                                added_to_group = True
                    if not added_to_group:
                        cell['group'] = g
                        g += 1
        
        print('initial grid: ', grid, '\n')
        group_cells(grid)
        print('grid: ', grid, '\n')
        
        return 0

test = Solution()
print(test.containVirus(isInfected =
                        [[0,1,0,0,0,0,0,1],
                         [0,1,0,0,0,0,0,1],
                         [0,0,0,0,0,0,0,1],
                         [0,0,0,0,0,0,0,0]]))
print(test.containVirus(isInfected =
                        [[0,1,1,1,0,0,0,1],
                         [0,1,0,1,0,0,0,1],
                         [0,1,1,1,0,0,0,1],
                         [0,0,0,0,0,0,0,0]]))

'''
https://leetcode.com/problems/contain-virus/

A virus is spreading rapidly, and your task is to quarantine the infected area by installing walls.

The world is modeled as an m x n binary grid isInfected, where isInfected[i][j] == 0 represents uninfected cells, and isInfected[i][j] == 1 represents cells contaminated with the virus. A wall (and only one wall) can be installed between any two 4-directionally adjacent cells, on the shared boundary.

Every night, the virus spreads to all neighboring cells in all four directions unless blocked by a wall. Resources are limited. Each day, you can install walls around only one region (i.e., the affected area (continuous block of infected cells) that threatens the most uninfected cells the following night). There will never be a tie.

Return the number of walls used to quarantine all the infected regions. If the world will become fully infected, return the number of walls used.

Example 1:

Input: isInfected = [[0,1,0,0,0,0,0,1],[0,1,0,0,0,0,0,1],[0,0,0,0,0,0,0,1],[0,0,0,0,0,0,0,0]]
Output: 10
Explanation: There are 2 contaminated regions.
On the first day, add 5 walls to quarantine the viral region on the left. The board after the virus spreads is:

On the second day, add 5 walls to quarantine the viral region on the right. The virus is fully contained.

Example 2:

Input: isInfected = [[1,1,1],[1,0,1],[1,1,1]]
Output: 4
Explanation: Even though there is only one cell saved, there are 4 walls built.
Notice that walls are only built on the shared boundary of two different cells.
Example 3:

Input: isInfected = [[1,1,1,0,0,0,0,0,0],[1,0,1,0,1,1,1,1,1],[1,1,1,0,0,0,0,0,0]]
Output: 13
Explanation: The region on the left only builds two new walls.

Constraints:

m == isInfected.length
n == isInfected[i].length
1 <= m, n <= 50
isInfected[i][j] is either 0 or 1.
There is always a contiguous viral region throughout the described process that will infect strictly more uncontaminated squares in the next round.

########
BELOW: Was trying to manage by groups, but may get too difficult (groups may merge, etc). Changes to manage by individual cells.
class Solution:
    def containVirus(self, isInfected: list[list[int]]) -> int:
        def adjacent(i, j):
            if i == 0:
                if j == 0:
                    return [(0, 1),(1, 0)]
                elif j == n - 1:
                    return [(0, j - 1),(1, j)]
                else:
                    return [(0, j - 1), (0, j + 1), (1, j)]
            elif i == m - 1:
                if j == 0:
                    return [(i, 1),(i - 1, 0)]
                elif j == n - 1:
                    return [(i, j - 1),(i - 1, j)]
                else:
                    return [(i, j - 1), (i, j + 1), (i - 1, j)]
            else:
                if j == 0:
                    return [(i, 1),(i - 1, 0), (i + 1, 0)]
                elif j == n - 1:
                    return [(i, j - 1),(i - 1, j), (i + 1, j)]
                else:
                    return [(i, j - 1), (i, j + 1), (i - 1, j), (i + 1, j)]
                
        def find_frontiers(grid, group):
            frontiers = []
            walls = 0
            for cell in group['cells']:
                adj = adjacent(*cell)
                for a in adj:
                    if not grid[a[0]][a[1]]:
                        walls += 1
                        if a not in frontiers:
                            frontiers.append(a)
            return frontiers, walls
        
        def find_groups(grid):
            groups = {}
            g = 0
            for i in range(m):
                for j in range(n):
                    if grid[i][j]:
                        adj = adjacent(i, j)
                        added = False
                        for a in adj:
                            for idx, group in groups.items():
                                if a in group['cells']:
                                    group['cells'].append((i, j))
                                    added = True
                                    break
                            if added:
                                break
                        if not added:
                            groups[g] = {'cells': [(i, j)]}
                            g += 1
            for group in groups.values():
                group['frontiers'], group['walls'] = find_frontiers(grid, group)
            return groups
        
        m = len(isInfected)
        n = len(isInfected[0])

        groups = find_groups(isInfected)

        print('groups: ', groups, '\n')
###########
'''