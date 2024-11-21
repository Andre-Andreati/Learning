function smaller(arr) {
    class BSTnode { // Binary Search Tree
      constructor(num) {
        this.val = num;
        this.count = 1;
        this.left = null;
        this.right = null;
        this.qtyLeft = 0;
      }
    }
  
    let insert = function(node, num, ans, qtyUpperLeft, i) {
      if (node == null) {
        ans.push(qtyUpperLeft);
        return new BSTnode(num);
      } else if (num == node.val) {
        node.count++;
        ans.push(qtyUpperLeft + node.qtyLeft);
      } else if (num < node.val) {
        node.qtyLeft++;
        node.left = insert(node.left, num, ans, qtyUpperLeft, i);
      } else {
        node.right = insert(node.right, num, ans, qtyUpperLeft+node.qtyLeft+node.count, i);
      }
      return node;
    }
  
    let ans = [];
    let node = null;
    for (let i=arr.length-1; i>=0; i--){
      node = insert(node, arr[i], ans, 0, i)
    }
  
    return ans.reverse();
  }

/*
https://www.codewars.com/kata/56a1c63f3bc6827e13000006

This is a hard version of How many are smaller than me?. If you have troubles solving this one, have a look at the easier kata first.

Write

function smaller(arr)
that given an array arr, you have to return the amount of numbers that are smaller than arr[i] to the right.

For example:

smaller([5, 4, 3, 2, 1]) === [4, 3, 2, 1, 0]
smaller([1, 2, 0]) === [1, 1, 0]
Note
Your solution will be tested against inputs with up to 120_000 elements
*/
