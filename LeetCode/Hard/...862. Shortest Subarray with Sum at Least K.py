class Solution:
    def shortestSubarray(self, nums: list[int], k: int) -> int:
        n = len(nums)
        start = 0
        s = 0
        shortest = n + 1

        for end in range(n):
            s += nums[end]
            while s >= k:
                shortest = min(shortest, end - start + 1)
                s -= nums[start]
                start += 1
        
        return shortest if shortest <= n else 0

test = Solution()
print(test.shortestSubarray(nums = [2,-1,2,3,5,-4,8,0,4,7,-6,3,3,5,9,-1], k = 15))

'''
NAIVE SOLUTION (correct answer but times out):

class Solution:
    def shortestSubarray(self, nums: list[int], k: int) -> int:
        n = len(nums)
        
        shortest = n + 1
        
        for i in range(n):
            s = 0
            for j in range(i, n):
                s += nums[j]
                if s >= k:
                    shortest = min(shortest, j - i + 1)
                print(i,j,s)
            
        return shortest if shortest <= n else -1
'''