def last_digit(a, b):
  if (b == 0):
    return 1
  lastA = a % 10
  if (lastA == 0):
    return 0
    
  d = dict()
  i = 1

  while ((lastA ** i) % 10 not in d.values()):
    d[i] = (lastA ** i) % 10
    d[0] = (lastA ** i) % 10
    i += 1

  print(d, len(d))
    
  m = b % (len(d)-1)
  print('lastA =', lastA, 'b =', 'm =', m)
  return d[m]

'''
https://www.codewars.com/kata/5511b2f550906349a70004e1

Define a function that takes in two non-negative integers a and b and returns the last decimal digit of a^b.
Note that a and b may be very large!

For example, the last decimal digit of 9^7 is 9, since 9^7 = 4782969
The last decimal digit of (2^200)^(2^300), which has over 10^92 decimal digits, is 6.
Also, please take 0^0 to be 1.

You may assume that the input will always be valid.

Examples
last_digit(4, 1)                # returns 4
last_digit(4, 2)                # returns 6
last_digit(9, 7)                # returns 9
last_digit(10, 10 ** 10)        # returns 0
last_digit(2 ** 200, 2 ** 300)  # returns 6

'''