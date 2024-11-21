class Solution:
    def lengthOfLIS(self, nums: list[int]) -> int:
        ans = []
        # Initialize the answer list with the first element of nums
        ans.append(nums[0])
        for i in range(1, len(nums)):
            if nums[i] > ans[-1]:
                # If the current number is greater than the last element of the answer
                # list, it means we have found a longer increasing subsequence.
                # Hence, we append the current number to the answer list.
                ans.append(nums[i])
            else:
                # If the current number is not greater than the last element of
                # the answer list, we perform a binary search to find the smallest
                # element in the answer list that is greater than or equal to the
                # current number.
                low = 0
                high = len(ans) - 1
                while low < high:
                    mid = low + (high - low) // 2
                    if ans[mid] < nums[i]:
                        low = mid + 1
                    else:
                        high = mid
                # We update the element at the found position with the current number.
                # By doing this, we are maintaining a sorted order in the answer list.
                ans[low] = nums[i]
        # The length of the answer list represents the length of the longest increasing subsequence.
        return len(ans)

'''
https://leetcode.com/problems/longest-increasing-subsequence

Given an integer array nums, return the length of the longest strictly increasing 
subsequence
.

 

Example 1:

Input: nums = [10,9,2,5,3,7,101,18]
Output: 4
Explanation: The longest increasing subsequence is [2,3,7,101], therefore the length is 4.
Example 2:

Input: nums = [0,1,0,3,2,3]
Output: 4
Example 3:

Input: nums = [7,7,7,7,7,7,7]
Output: 1
 

Constraints:

1 <= nums.length <= 2500
-104 <= nums[i] <= 104
 

Follow up: Can you come up with an algorithm that runs in O(n log(n)) time complexity?
'''