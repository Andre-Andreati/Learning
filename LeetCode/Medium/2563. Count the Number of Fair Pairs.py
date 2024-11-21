class Solution:
    def countFairPairs(self, nums: list[int], lower: int, upper: int) -> int:
        def left(nums, low, high, num):
            while low <= high:
                mid = low + ((high - low) // 2)
                if nums[mid] >= num:
                    high = mid - 1
                else:
                    low = mid+1
            return low
        
        nums.sort()
        ans = 0
        for i in range(len(nums)):
            start = left(nums, i + 1, len(nums) - 1, lower - nums[i])
            end = left(nums, i + 1, len(nums) - 1, upper - nums[i] + 1)
            ans += end - start

        return ans
        
    
test = Solution()
print(test.countFairPairs(nums = [0,1,7,4,4,5], lower = 3, upper = 6))

'''
https://leetcode.com/problems/count-the-number-of-fair-pairs

Given a 0-indexed integer array nums of size n and two integers lower and upper, return the number of fair pairs.

A pair (i, j) is fair if:

0 <= i < j < n, and
lower <= nums[i] + nums[j] <= upper
 

Example 1:

Input: nums = [0,1,7,4,4,5], lower = 3, upper = 6
Output: 6
Explanation: There are 6 fair pairs: (0,3), (0,4), (0,5), (1,3), (1,4), and (1,5).
Example 2:

Input: nums = [1,7,9,2,5], lower = 11, upper = 11
Output: 1
Explanation: There is a single fair pair: (2,3).
 

Constraints:

1 <= nums.length <= 105
nums.length == n
-109 <= nums[i] <= 109
-109 <= lower <= upper <= 109
'''
'''
NAIVE SOLUTION (correct result but times out):

class Solution:
    def countFairPairs(self, nums: list[int], lower: int, upper: int) -> int:
        n_pairs = 0
        for i in range(len(nums)):
            for j in range(i+1, len(nums)):
                if lower <= nums[i] + nums[j] <= upper:
                    n_pairs += 1
        return n_pairs
'''