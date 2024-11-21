class Solution:
    def minimumTotalDistance(self, robot: list[int], factory: list[list[int]]) -> int:
        fac = []
        for item in factory: #for each factory, create 'n' facs, where 'n' is the limit robots the factory can repair
            fac += ([item[0]] * item[1])
        robot.sort()
        fac.sort()
        robot_count = len(robot)
        factory_count = len(fac)

        memo = [[-1] * (factory_count + 1) for _ in range(robot_count + 1)]

        def calculate_min_distance(robot_idx: int, factory_idx: int) -> int:
            if memo[robot_idx][factory_idx] != -1:
                return memo[robot_idx][factory_idx]
            if robot_idx == robot_count:
                memo[robot_idx][factory_idx] = 0
                return 0
            if factory_idx == factory_count:
                memo[robot_idx][factory_idx] = int(1e12)
                return int(1e12)

            assign = abs(
                robot[robot_idx] - fac[factory_idx]
            ) + calculate_min_distance(robot_idx + 1, factory_idx + 1)

            skip = calculate_min_distance(robot_idx, factory_idx + 1)

            memo[robot_idx][factory_idx] = min(assign, skip)
            return memo[robot_idx][factory_idx]

        return calculate_min_distance(0, 0)

    
test = Solution()
print(test.minimumTotalDistance(robot = [0,4,6], factory = [[2,2],[6,2],[1,1],[7,3]]))

'''
https://leetcode.com/problems/minimum-total-distance-traveled

There are some robots and factories on the X-axis. You are given an integer array robot where robot[i] is the position of the ith robot. You are also given a 2D integer array factory where factory[j] = [positionj, limitj] indicates that positionj is the position of the jth factory and that the jth factory can repair at most limitj robots.

The positions of each robot are unique. The positions of each factory are also unique. Note that a robot can be in the same position as a factory initially.

All the robots are initially broken; they keep moving in one direction. The direction could be the negative or the positive direction of the X-axis. When a robot reaches a factory that did not reach its limit, the factory repairs the robot, and it stops moving.

At any moment, you can set the initial direction of moving for some robot. Your target is to minimize the total distance traveled by all the robots.

Return the minimum total distance traveled by all the robots. The test cases are generated such that all the robots can be repaired.

Note that

All robots move at the same speed.
If two robots move in the same direction, they will never collide.
If two robots move in opposite directions and they meet at some point, they do not collide. They cross each other.
If a robot passes by a factory that reached its limits, it crosses it as if it does not exist.
If the robot moved from a position x to a position y, the distance it moved is |y - x|.
 
Example 1:

Input: robot = [0,4,6], factory = [[2,2],[6,2]]
Output: 4
Explanation: As shown in the figure:
- The first robot at position 0 moves in the positive direction. It will be repaired at the first factory.
- The second robot at position 4 moves in the negative direction. It will be repaired at the first factory.
- The third robot at position 6 will be repaired at the second factory. It does not need to move.
The limit of the first factory is 2, and it fixed 2 robots.
The limit of the second factory is 2, and it fixed 1 robot.
The total distance is |2 - 0| + |2 - 4| + |6 - 6| = 4. It can be shown that we cannot achieve a better total distance than 4.
Example 2:

Input: robot = [1,-1], factory = [[-2,1],[2,1]]
Output: 2
Explanation: As shown in the figure:
- The first robot at position 1 moves in the positive direction. It will be repaired at the second factory.
- The second robot at position -1 moves in the negative direction. It will be repaired at the first factory.
The limit of the first factory is 1, and it fixed 1 robot.
The limit of the second factory is 1, and it fixed 1 robot.
The total distance is |2 - 1| + |(-2) - (-1)| = 2. It can be shown that we cannot achieve a better total distance than 2.
 
Constraints:

1 <= robot.length, factory.length <= 100
factory[j].length == 2
-109 <= robot[i], positionj <= 109
0 <= limitj <= robot.length
The input will be generated such that it is always possible to repair every robot.
'''
'''
BRUTE FORCE (correct result but times out):
import itertools

def matrix_of_distances(robot, fac):
    matrix = [] #len(robot) x len(fac) matrix with the distance from each robot (line) to each fac (col)
    for r in sorted(robot):
        line = []
        for f in sorted(fac):
            line.append(abs(r-f))
        matrix.append(line)
    print(*matrix,sep='\n')
    print('\n')
    return matrix

class Solution:
    def minimumTotalDistance(self, robot: list[int], factory: list[list[int]]) -> int:
        fac = []
        for item in factory: #for each factory, create 'n' facs, where 'n' is the limit robots the factory can repair
            fac += ([item[0]] * item[1])
        robot.sort()
        fac.sort()
        
        ans = 0
        
        moved = True
        while moved == True: #move the robots that are farther left or right than the farthest factories
            if robot[0] <= fac[0]:
                ans += abs(robot[0] - fac[0])
                moved = True
                robot.pop(0)
                fac.pop(0)
            elif robot[-1] >= fac[-1]:
                ans += abs(robot[-1] - fac[-1])
                moved = True
                robot.pop(-1)
                fac.pop(-1)
            else:
                moved = False
                
        print(robot, len(robot))
        print(fac, len(fac), '\n')
        matrix = matrix_of_distances(robot, fac)
        
        indices = list(itertools.combinations(range(len(fac)), len(robot))) #list of tuples, each containing the possible indices of the facs to be visited by each robot:
        # [
        #     (i of first possible fac visited by first robot , i of first possible fac visited by second robot , ...), #first possible combination
        #     (i of second possible fac visited by first robot , i of second possible fac visited by second robot, ...), #second possible combination
        #     ...
        # ]
        print(indices)
        distances = []
        for i in range(len(indices)):
            dist = 0
            for j in range(len(indices[i])):
                dist += matrix[j][indices[i][j]]
            distances.append(dist)
        return ans + min(distances)
'''