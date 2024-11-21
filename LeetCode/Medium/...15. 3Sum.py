class Solution:
    def threeSum(self, nums: list[int]) -> list[list[int]]:
        n = len(nums)
        sumsSet = {}
        ans = set()

        for i in range(n):
            for j in range(i + 1, n):
                s = nums[i] + nums[j]
                if s not in sumsSet:
                    sumsSet[s] = []
                sumsSet[s].append([i,j]) #hashtable with all possible sums:
                # {sum0: [[idx1, idx2], [idx3, idx4], ...], sum1: [[idx1, idx3], ...], ...}

        for i in range(n):
            comp = 0 - nums[i]
            if comp in sumsSet: #search the complement of each element in the hash table
                for duo in sumsSet[comp]:
                    if i != duo[0] and i != duo[1]: #if the element is not already present
                        triplet = sorted([nums[i], nums[duo[0]], nums[duo[1]]])
                        ans.add(tuple(triplet)) #have to transform to tuple because lists
                            # are not hashable, so cant be added to a set. Have to use a set
                            # to avoid duplicates

        return [list(arr) for arr in ans] #transforms back to lists and returns

test = Solution()
print(test.threeSum(nums = [-1,0,1,2,-1,-4]))

'''
https://leetcode.com/problems/3sum/

Given an integer array nums, return all the triplets [nums[i], nums[j], nums[k]]
such that i != j, i != k, and j != k, and nums[i] + nums[j] + nums[k] == 0.

Notice that the solution set must not contain duplicate triplets.

 
Example 1:

Input: nums = [-1,0,1,2,-1,-4]
Output: [[-1,-1,2],[-1,0,1]]
Explanation: 
nums[0] + nums[1] + nums[2] = (-1) + 0 + 1 = 0.
nums[1] + nums[2] + nums[4] = 0 + 1 + (-1) = 0.
nums[0] + nums[3] + nums[4] = (-1) + 2 + (-1) = 0.
The distinct triplets are [-1,0,1] and [-1,-1,2].
Notice that the order of the output and the order of the triplets does not matter.
Example 2:

Input: nums = [0,1,1]
Output: []
Explanation: The only possible triplet does not sum up to 0.
Example 3:

Input: nums = [0,0,0]
Output: [[0,0,0]]
Explanation: The only possible triplet sums up to 0.

Constraints:

3 <= nums.length <= 3000
-105 <= nums[i] <= 105
'''
'''
Hashing approach - correct answer but times out:

class Solution:
    def threeSum(self, nums: list[int]) -> list[list[int]]:
        n = len(nums)
        sumsSet = {}
        ans = set()

        for i in range(n):
            for j in range(i + 1, n):
                s = nums[i] + nums[j]
                if s not in sumsSet:
                    sumsSet[s] = []
                sumsSet[s].append([i,j]) #hashtable with all possible sums:
                # {sum0: [[idx1, idx2], [idx3, idx4], ...], sum1: [[idx1, idx3], ...], ...}

        for i in range(n):
            comp = 0 - nums[i]
            if comp in sumsSet: #search the complement of each element in the hash table
                for duo in sumsSet[comp]:
                    if i != duo[0] and i != duo[1]: #if the element is not already present
                        triplet = sorted([nums[i], nums[duo[0]], nums[duo[1]]])
                        ans.add(tuple(triplet)) #have to transform to tuple because lists
                            # are not hashable, so cant be added to a set. Have to use a set
                            # to avoid duplicates

        return [list(arr) for arr in ans] #transforms back to lists and returns
'''