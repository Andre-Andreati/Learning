class Solution:
    def decrypt(self, code: list[int], k: int) -> list[int]:
        n = len(code)

        if k == 0:
            return [0] * n
        
        ans = []
        sign = int(k / abs(k)) #+1 if k>0, -1 if k<0
        for i in range(n):
            ans.append(0)
            for j in range(0, k, sign):
                ans[i] += code[(i + j + sign) % n]

        return ans

test = Solution()
print(test.decrypt(code = [2,4,9,3], k = -2))