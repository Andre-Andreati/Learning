def sudoku(puzzle):
  def box(r,c):
    if (r < 3):
      if (c < 3): return 1
      if (c < 6): return 2
      return 3
    if (r < 6):
      if (c < 3): return 4
      if (c < 6): return 5
      return 6
    if (c < 3): return 7
    if (c < 6): return 8
    return 9

  def findPossible(obj, i, j):
    possible = {1,2,3,4,5,6,7,8,9}
    row = obj[''+str(i)+str(j)]['row']
    collumn = obj[''+str(i)+str(j)]['collumn']
    box = obj[''+str(i)+str(j)]['box']
    for item in obj:
      if (item != ''+str(i)+str(j) and obj[item]['value'] != 0 and (obj[item]['row'] == row or obj[item]['collumn'] == collumn or obj[item]['box'] == box)):
        possible.discard(obj[item]['value'])
    return possible

  def toObj(arr):
    obj = dict()
    for i in range(len(arr)):
      for j in range(len(arr[i])):
        obj[''+str(i)+str(j)]={};
        obj[''+str(i)+str(j)]['value'] = arr[i][j]
        obj[''+str(i)+str(j)]['row'] = i
        obj[''+str(i)+str(j)]['collumn'] = j
        obj[''+str(i)+str(j)]['box'] = box(i,j)
    return obj

  def toArray(obj):
    arr = [[0,0,0,0,0,0,0,0,0],
           [0,0,0,0,0,0,0,0,0],
           [0,0,0,0,0,0,0,0,0],
           [0,0,0,0,0,0,0,0,0],
           [0,0,0,0,0,0,0,0,0],
           [0,0,0,0,0,0,0,0,0],
           [0,0,0,0,0,0,0,0,0],
           [0,0,0,0,0,0,0,0,0],
           [0,0,0,0,0,0,0,0,0]]
    for item in obj:
      arr[obj[item]['row']][obj[item]['collumn']] = obj[item]['value']
    return(arr)

  obj = toObj(puzzle)

  while len(list(filter(lambda item: item['value']==0, obj.values()))) > 0:
    for item in obj:
      if (obj[item]['value'] == 0):
        possible = findPossible(obj, obj[item]['row'], obj[item]['collumn'])
        if (len(possible) == 1):
          obj[item]['value'] = list(possible)[0]

  arr = toArray(obj)

  return arr

'''
https://www.codewars.com/kata/5296bc77afba8baa690002d7

Write a function that will solve a 9x9 Sudoku puzzle. The function will take one argument consisting of the 2D puzzle array, with the value 0 representing an unknown square.

The Sudokus tested against your function will be "easy" (i.e. determinable; there will be no need to assume and test possibilities on unknowns) and can be solved with a brute-force approach.

For Sudoku rules, see the Wikipedia article.

puzzle = [[5,3,0,0,7,0,0,0,0],
          [6,0,0,1,9,5,0,0,0],
          [0,9,8,0,0,0,0,6,0],
          [8,0,0,0,6,0,0,0,3],
          [4,0,0,8,0,3,0,0,1],
          [7,0,0,0,2,0,0,0,6],
          [0,6,0,0,0,0,2,8,0],
          [0,0,0,4,1,9,0,0,5],
          [0,0,0,0,8,0,0,7,9]]

sudoku(puzzle)
# Should return
 [[5,3,4,6,7,8,9,1,2],
  [6,7,2,1,9,5,3,4,8],
  [1,9,8,3,4,2,5,6,7],
  [8,5,9,7,6,1,4,2,3],
  [4,2,6,8,5,3,7,9,1],
  [7,1,3,9,2,4,8,5,6],
  [9,6,1,5,3,7,2,8,4],
  [2,8,7,4,1,9,6,3,5],
  [3,4,5,2,8,6,1,7,9]]
  '''