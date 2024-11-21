class Solution:
    def minSubArrayLen(self, target: int, nums: list[int]) -> int:
        n = len(nums)
        start = 0
        s = 0
        shortest = n + 1

        for end in range(n):
            s += nums[end]
            while s >= target:
                shortest = min(shortest, end - start + 1)
                s -= nums[start]
                start += 1
        
        return shortest if shortest <= n else 0
    
test = Solution()
print(test.minSubArrayLen(target = 7, nums = [2,3,1,2,4,3]))