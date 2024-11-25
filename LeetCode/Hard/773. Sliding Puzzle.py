class Solution:
    def slidingPuzzle(self, board: list[list[int]]) -> int:
        def move(string, zero_idx, other_idx): #swaps the positions of the zero and the other number 
            arr = list(string)
            arr[zero_idx] = arr[other_idx]
            arr[other_idx] = '0'
            return "".join(arr)
        
        #possible moves from each position
        poss_moves = {0: [1, 3], 1: [0, 2, 4], 2: [1, 5], 3: [0, 4], 4: [1, 3, 5], 5: [2, 4]}
        
        start = ''.join(str(num) for row in board for num in row)
        goal = '123450'
        
        visited = set()
        to_visit = set()
        to_visit.add(start)
        n = 0
        
        #BFS(breadth first search):
        #On each iteration, check if any of the boards in the to_visit set is the goal. If so, return the number of moves.
        #If not, add the each current board to the visited set and check all possible moves from the current board.
        #If a move is not in the visited set and is not in the to_visit set, add it to the to_visit set and increase the number of moves.
        while to_visit:
            next_boards = set() #all the boards that can be reached from the current board
            for i in range(len(to_visit)):
                current = to_visit.pop() #get the current board and remove it from the to_visit set
                if current == goal:
                    return n
                visited.add(current) #add the current board to the visited set
                
                for poss_move in poss_moves[current.index('0')]: #all the boards that can be reached from the current board
                    new_board = move(current, current.index('0'), poss_move)
                    if new_board not in visited and new_board not in to_visit:
                        next_boards.add(new_board) #all the boards that can be reached from the current board, and have not yet been visited
            to_visit.update(next_boards) #add the new boards to the to_visit set, only if none of the previous borders is the goal
            n += 1
            
        return -1 #if there are no more possible moves
    
test = Solution()
print(test.slidingPuzzle(board = [[4,1,2],[5,0,3]]))

'''
https://leetcode.com/problems/sliding-puzzle

On an 2 x 3 board, there are five tiles labeled from 1 to 5, and an empty square represented by 0. A move consists of choosing 0 and a 4-directionally adjacent number and swapping it.

The state of the board is solved if and only if the board is [[1,2,3],[4,5,0]].

Given the puzzle board board, return the least number of moves required so that the state of the board is solved. If it is impossible for the state of the board to be solved, return -1.

Example 1:

Input: board = [[1,2,3],[4,0,5]]
Output: 1
Explanation: Swap the 0 and the 5 in one move.
Example 2:

Input: board = [[1,2,3],[5,4,0]]
Output: -1
Explanation: No number of moves will make the board solved.
Example 3:

Input: board = [[4,1,2],[5,0,3]]
Output: 5
Explanation: 5 is the smallest number of moves that solves the board.
An example path:
After move 0: [[4,1,2],[5,0,3]]
After move 1: [[4,1,2],[0,5,3]]
After move 2: [[0,1,2],[4,5,3]]
After move 3: [[1,0,2],[4,5,3]]
After move 4: [[1,2,0],[4,5,3]]
After move 5: [[1,2,3],[4,5,0]]
'''