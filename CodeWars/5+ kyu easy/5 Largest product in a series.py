def greatest_product(st):
  greatest = 0
  for i in range(len(st)-4):
    if(int(st[i])*int(st[i+1])*int(st[i+2])*int(st[i+3])*int(st[i+4]) > greatest):
      greatest = int(st[i])*int(st[i+1])*int(st[i+2])*int(st[i+3])*int(st[i+4])
  return greatest

'''
https://www.codewars.com/kata/529872bdd0f550a06b00026e

Complete the greatestProduct method so that it'll find the greatest product of five consecutive digits in the given string of digits.

For example: the greatest product of five consecutive digits in the string "123834539327238239583" is 3240.

The input string always has more than five digits.

Adapted from Project Euler.
'''