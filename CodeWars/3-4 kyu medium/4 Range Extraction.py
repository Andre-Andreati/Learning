def solution(args):
  ans = str(args[0])
  length = len(args)
  count = 0
  for i in range(1, length):
    print(i, args[i])
    if(args[i] - args[i-1] != 1):
      if(count == 0):
        ans += ',' + str(args[i])
      else:
        if(count > 1):
          ans += '-' + str(args[i-1]) + ',' + str(args[i])
          count = 0
        else:
          ans += ',' + str(args[i-1]) + ',' + str(args[i])
          count = 0
    else:
      if(i==length-1):
        print('last')
        if(count == 0):
          ans += ',' + str(args[i])
        else:
          ans += '-' + str(args[i])
      count += 1

  return ans

'''
https://www.codewars.com/kata/51ba717bb08c1cd60f00002f

A format for expressing an ordered list of integers is to use a comma separated list of either

individual integers
or a range of integers denoted by the starting integer separated from the end integer in the range by a dash, '-'. The range includes all integers in the interval including both endpoints. It is not considered a range unless it spans at least 3 numbers. For example "12,13,15-17"
Complete the solution so that it takes a list of integers in increasing order and returns a correctly formatted string in the range format.

Example:

solution([-10, -9, -8, -6, -3, -2, -1, 0, 1, 3, 4, 5, 7, 8, 9, 10, 11, 14, 15, 17, 18, 19, 20])
# returns "-10--8,-6,-3-1,3-5,7-11,14,15,17-20"
Courtesy of rosettacode.org
'''