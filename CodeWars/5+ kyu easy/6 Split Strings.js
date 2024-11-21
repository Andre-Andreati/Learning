function solution(str){
    let ans = [];
    for (let i=0; i<str.length; i+=2) {
      ans.push(str.slice(i,i+2).length == 2 ? str.slice(i,i+2) : str.slice(i,i+2)+'_')
    }
    return ans;
  }

/*
https://www.codewars.com/kata/515de9ae9dcfc28eb6000001

Complete the solution so that it splits the string into pairs of two characters. If the string contains an odd number of characters then it should replace the missing second character of the final pair with an underscore ('_').

Examples:

* 'abc' =>  ['ab', 'c_']
* 'abcdef' => ['ab', 'cd', 'ef']
*/