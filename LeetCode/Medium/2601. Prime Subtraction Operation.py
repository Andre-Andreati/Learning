def primes_list(n): #returns list with all primes up to n (using Sieve of Eratosthenes)
    prime = [True for i in range(n+1)]
    p = 2
    while(p * p <= n):
        if (prime[p] == True):
            # Update all multiples of p
            for i in range(p * p, n + 1, p):
                prime[i] = False
        p += 1
    ans = []
    for i in range(2, n):
        if prime[i]:
            ans.append(i)
    return ans

class Solution:
    def primeSubOperation(self, nums: List[int]) -> bool:
        primes = primes_list(max(nums)) #list with all primes up to max in nums
        arr = nums.copy()
        p = [x for x in primes if x < nums[0]] #list with all primes less than current num
        if p:
            arr[0] = nums[0] - max(p) #first element in the result will be the smallest possible,
                                      # i.e. removing the largest possible prime from the original element
        for i in range(1, len(nums)):
            p = [x for x in primes if x < nums[i]] ##list with all primes less than current num
            for x in reversed(p): #iterates through the possible primes from largest to smaller
                if arr[i] - x > arr[i-1]: #if subtracting the current prime from the current num is larger than the previous num
                    arr[i] = arr[i] - x #replace the num with the result of the substraction
                    break #if it is larger, it is the smallest possible number that is larger than the previous num
                    #if the subtraction is NOT larger than the previous, go to the next possible prime,
                    # until find one where the substraction is larger than the previous num.
                    #If none is find, just keep the original num
        return all(arr[i] < arr[i + 1] for i in range(len(arr) - 1)) #check if is sorted

'''
https://leetcode.com/problems/prime-subtraction-operation

You are given a 0-indexed integer array nums of length n.

You can perform the following operation as many times as you want:

Pick an index i that you haven’t picked before, and pick a prime p strictly less than nums[i], then subtract p from nums[i].
Return true if you can make nums a strictly increasing array using the above operation and false otherwise.

A strictly increasing array is an array whose each element is strictly greater than its preceding element.

 

Example 1:

Input: nums = [4,9,6,10]
Output: true
Explanation: In the first operation: Pick i = 0 and p = 3, and then subtract 3 from nums[0], so that nums becomes [1,9,6,10].
In the second operation: i = 1, p = 7, subtract 7 from nums[1], so nums becomes equal to [1,2,6,10].
After the second operation, nums is sorted in strictly increasing order, so the answer is true.
Example 2:

Input: nums = [6,8,11,12]
Output: true
Explanation: Initially nums is sorted in strictly increasing order, so we don't need to make any operations.
Example 3:

Input: nums = [5,8,3]
Output: false
Explanation: It can be proven that there is no way to perform operations to make nums sorted in strictly increasing order, so the answer is false.
 

Constraints:

1 <= nums.length <= 1000
1 <= nums[i] <= 1000
nums.length == n
'''