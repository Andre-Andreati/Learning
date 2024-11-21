class Solution:
    def maximumBeauty(self, items: list[list[int]], queries: list[int]) -> list[int]:
        sorted_items = sorted(items) #sort items by price, and by beuty among item with same price
        sorted_enum_queries = sorted([[i, q] for i, q in enumerate(queries)], key=lambda x: x[1])
        # ^sort queries keeping track of original index

        ans = [0]*len(queries)
        idx = 0
        largest = 0
        #Iterates through sorted_items until find an item that can't be afforded.
        #Stores the largest beauty up to it.
        #For the next query, start iterating from the first that could'n be afforded,
        #and comparing it to the previous largest.
        for query in sorted_enum_queries:
            while idx < len(sorted_items):
                if sorted_items[idx][0] <= query[1]: #if item can be afforded
                    largest = max(largest, sorted_items[idx][1]) #update the largest
                    idx += 1
                else:
                    break
            ans[query[0]] = largest #stores the largest value that query can afford,
                                    #in the original query's position on queries list
        return ans
    
test = Solution()
print(test.maximumBeauty(items = [[1,2],[3,2],[2,4],[5,6],[3,5]], queries = [1,2,3,4,5,6]))