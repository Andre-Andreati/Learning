class Solution:
    def minEnd(self, n: int, x: int) -> int:
        # Each element of the array should be obtained by “merging” x and v where v = 0, 1, 2, …(n - 1).
        # To merge x with another number v, keep the set bits of x untouched, for all the other bits, fill the set bits of v from right to left in order one by one.
        # So the final answer is the “merge” of x and n - 1.
        xb = format(x, 'b')
        mb = format(n-1, 'b')
        ansb = xb
        j = len(mb) - 1
        for i in range(len(xb)-1, -1, -1):
            if xb[i] == '0' and j >= 0:
                ansb = ansb[: i] + mb[j] + ansb[i + 1 :]
                j -= 1
        return int(mb[0 : j + 1] + ansb, 2)

'''
NAIVE SOLUTION: (correct answer but times out)

class Solution:
    def minEnd(self, n: int, x: int) -> int:
        def nxt(m, init): #returns the next number greater than 'm' that have 'ones' at all positions where 'init' have 'ones'
            i = 1
            while True:
                if (m + i) & init == init:
                    return m + i
                i += 1
        ans = [x] #first element of the result array will always be the target 'x'
        for i in range(1, n):
            ans.append(nxt(ans[-1], x)) #appends next number that will keep the "AND operation" requisite
        return ans[-1]
'''

'''
https://leetcode.com/problems/minimum-array-end

You are given two integers n and x. You have to construct an array of positive integers nums of size n where for every 0 <= i < n - 1, nums[i + 1] is greater than nums[i], and the result of the bitwise AND operation between all elements of nums is x.

Return the minimum possible value of nums[n - 1].

 

Example 1:

Input: n = 3, x = 4

Output: 6

Explanation:

nums can be [4,5,6] and its last element is 6.

Example 2:

Input: n = 2, x = 7

Output: 15

Explanation:

nums can be [7,15] and its last element is 15.

 

Constraints:

1 <= n, x <= 108
'''