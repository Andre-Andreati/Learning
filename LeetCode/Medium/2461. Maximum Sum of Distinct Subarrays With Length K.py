class Solution:
    def maximumSubarraySum(self, nums: list[int], k: int) -> int:        
        n = len(nums)
        elems = {}

        s = 0
        init = nums[: k]
        unique = True
        for el in init:
            s += el
            if el not in elems:
                elems[el] = 1
            else:
                elems[el] += 1
                unique = False

        ans = s if unique else 0

        for i in range(k, n):
            s = s - nums[i - k] + nums[i]
            if nums[i] not in elems:
                elems[nums[i]] = 0
            elems[nums[i]] += 1
            elems[nums[i - k]] -= 1
            if elems[nums[i - k]] == 0:
                del elems[nums[i - k]]
            if s > ans and len(elems) == k:
                ans = s

        return ans

test = Solution()
print(test.maximumSubarraySum(nums = [9,9,1,5,5,2,9,9,10,9], k = 3))