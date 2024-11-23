class Solution:
    def containVirus(self, isInfected: list[list[int]]) -> int:
        def adjacent(i, j): #returns all the cells adjacent to i,j
            possible = set([])
            for item in [(i, j - 1), (i, j + 1), (i - 1, j), (i + 1, j)]:
                if item in grid:
                    possible.add(item)
            return possible
                
        def mark_all_group(idx): #locate and update all contiguous contaminated cells
            possible = grid[idx]['adjacent'].copy() #all adjacent cells may be of same group
            group = grid[idx]['group']
            added_cell = True
            while added_cell == True:
                added_cell = False
                next_possible = set([])
                cells_to_remove = set([])
                for cell in possible:
                    if grid[cell]['infected'] and grid[cell]['group'] is None and grid[cell]['status'] == 'open':
                        grid[cell]['group'] = group #add group to the cell
                        groups[group]['cells'].update(set([(cell)])) #add the cell to the group
                        added_cell = True
                        next_possible.update(set(grid[cell]['adjacent'])) #the cells adjacent to the added one may be of same group
                    cells_to_remove.add(cell) #this cell have already been analyzed, can now be removed from 'possible' list
                possible.update(next_possible)
                possible.difference_update(cells_to_remove)
                
        def group_cells(): #groups contiguous infected cells, ignores contained
            groups.clear() #reset groups dict
            for idx, cell in grid.items():
                cell['group'] = None #reset group value for all cells
                cell['adjacent'] = adjacent(*idx) #set of tuples containing the adjacents cells
            for idx, cell in grid.items():
                if cell['status'] == 'closed': #ignoring contained cells
                    continue
                if cell['infected'] and cell['group'] is None: #if cell is infected and not have a group yet
                    if not groups: #if no group have been created, create one and add curent cell to it
                        groups[1] = {'cells': set([(idx)])}
                    else: #if there's already a group, create the next one and add current cell
                        groups[list(groups.keys())[-1] + 1] = {'cells': set([(idx)])}
                    cell['group'] = list(groups.keys())[-1] #update the cell's 'group' value with the group
                    mark_all_group(idx) #locate and update all contiguous contaminated cells
        
        def find_frontiers(): #add the frontiers for each group, and the number of walls to be added if this group gets isolated
            for i, group in groups.items():
                group['frontiers'] = set()
                group['walls'] = 0
                for cell in group['cells']:
                    for adj in grid[cell]['adjacent']:
                        if not grid[adj]['infected']:
                            group['frontiers'].add(adj) #add every uninfected adjacent cell to 'frontiers' set
                            group['walls'] += 1 #one more wall have to be created
        
        def isolate(): #isolates the group with largest frontier, update 'walls' list
            largest_frontier = max([ (i, len(group['frontiers'])) for i, group in groups.items() ], key= lambda x: x[1])[0]
                #finds group with largest frontier
            walls.append(groups[largest_frontier]['walls']) #update wall list with wall size for the largest frontier
            for idx, cell in grid.items():
                if cell['group'] == largest_frontier:
                    cell['status'] = 'closed' #contains the cells in this group
            del groups[largest_frontier] #removes the contained group
        
        def propagate(): #propagate the other groups
            for i, group in groups.items():
                for cell in group['frontiers']:
                    grid[cell]['infected'] = 1 #each frontier cell of the remaining groups (nor contained) are infected
            
        m = len(isInfected)
        n = len(isInfected[0])
        groups = {} #for controlling the groups
        walls = [0] #walls constructed on each iteration
        
        grid = {} #dict with each cell's indexes as keys, and an dict with the cell's properties as values
        for i in range(m):
            for j in range(n):
                grid[(i, j)] = {'infected': isInfected[i][j], #1 for infected
                                'group': None, #group in wich the cell pertences
                                'status': 'open'} #'closed' if the cell have been contained/walled

        prev_walls = -1
        while sum(walls) != prev_walls: #stops the iteration when no wall is added
            prev_walls = sum(walls) #for control if any wall will be added
            group_cells() #clears the previous groups, makes new groups, ignoring the contained cells.
                          #coded this way to avoid complications with merging groups etc
            if groups: #if all infected cells are contained, no new group will be created, loop will end
                find_frontiers() #add the frontiers for each group
                isolate() #isolates the group with largest frontier, update 'walls' list
                propagate() #propagate the other groups
        
        return sum(walls)

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