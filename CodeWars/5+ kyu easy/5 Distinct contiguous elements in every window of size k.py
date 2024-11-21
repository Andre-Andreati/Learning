def count_contiguous_distinct(k, arr):
  length = len(arr)
  arrays = []
  distinct_count = 0
  element_count = {}
  
  for i in range(length):
      if i >= k:
          element_count[arr[i - k]] -= 1
          if element_count[arr[i - k]] == 0:
              distinct_count -= 1
      if arr[i] not in element_count or element_count[arr[i]] == 0:
          distinct_count += 1
      element_count[arr[i]] = element_count.get(arr[i], 0) + 1
      if i >= k - 1:
          arrays.append(distinct_count)
  return arrays

'''
https://www.codewars.com/kata/5945f0c207693bc53100006b

Count distinct elements in every window of size k
Given an array of size n, and an integer k, return the count of distinct contiguous numbers for all windows of size k.
k will always be lower than or equal to n.

Example
Input: array = {1, 2, 1, 3, 4, 2, 3}
       k = 4
Since we have n = 7 and k = 4, we have 4 windows with 4 contiguous elements.
       
Answer: [3,4,4,3]
Explanation
1st window is `{1, 2, 1, 3}`, which has `3` distinct numbers
2nd window is `{2, 1, 3, 4}`, which has `4` distinct numbers
3rd window is `{1, 3, 4, 2}`, which has `4` distinct numbers
4th window is `{3, 4, 2, 3}`, which has `3` distinct numbers
WARNING
Be careful about performance: your function will have to manage 150 random tests with arrays of length between 10 000 and 20 000 and size of the window between 1 000 and 10 000 !
'''