# Code_1

## 1. 二叉树的最近公共祖先（Leetcode 236）

```
// C

/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     struct TreeNode *left;
 *     struct TreeNode *right;
 * };
 */
struct TreeNode* lowestCommonAncestor(struct TreeNode* root, struct TreeNode* p, struct TreeNode* q) {
    if(root == NULL) return NULL;
    if(root == p || root == q) return root;
            
    struct TreeNode* left =  lowestCommonAncestor(root->left, p, q);
    struct TreeNode* right = lowestCommonAncestor(root->right, p, q);
       
    if(left == NULL) return right;
    if(right == NULL) return left;      
    if(left && right) return root; // p 和 q 在两侧

    return NULL; 
}

```

## 2.丑数（剑指 Offer 49 ）


```
// C

int nthUglyNumber(int n){
    int u2 = 0,u3 = 0,u5 = 0;
    int u[n];
    u[0] = 1;
    for (int i = 1; i < n; i++){
        int v2 = u[u2]*2;
        int v3 = u[u3]*3;
        int v5 = u[u5]*5;
        int min = v2 < v3 ? v2 : v3;
        u[i] = min < v5 ? min : v5;
        if (u[i] == v2) u2++;
        if (u[i] == v3) u3++;
        if (u[i] == v5) u5++;
    }
    return u[n-1];
}

```

## 3.前 K 个高频元素（Leetcode 347）


``` 
// C ++

#include <stdio.h>
#include <stack>
#include <vector>
#include <unordered_map>
#include <queue>
#include <utility>
#include <algorithm>

class TopKFrequentSolution {
public:
    std::vector<int> topKFrequent(std::vector<int>& nums, int k) {
        std::unordered_map<int,int> record;
        for (int i = 0; i < nums.size(); i++){
            record[nums[i]] ++;
        }
        std::priority_queue<std::pair<int,int>,std::vector<std::pair<int,int>>,std::greater<std::pair<int,int>>> minHeap;
        for (auto iter = record.begin(); iter!=record.end(); iter++){
            if(minHeap.size() == k){
                if(minHeap.top().first < iter->second){
                    minHeap.pop();
                    minHeap.push(std::make_pair(iter->second,iter->first));
                }
            } else {
                minHeap.push(std::make_pair(iter->second,iter->first));
            }
        }
        std::vector<int> result;
        while(minHeap.size()) {
            result.push_back(minHeap.top().second);
            minHeap.pop();
        }
        reverse(result.begin(),result.end());
        return result;
    }
};

```

## 4.盛最多水的容器（Leetcode 11）

```
int maxArea(int* height, int heightSize){
    int i = 0, j = heightSize-1;
    int h =  height[i]<height[j] ? height[i] : height[j];
    int max = h*(j-i);
    while (i < j){
        height[i]<height[j] ? i++ : j--;
        int h =  height[i]<height[j] ? height[i] : height[j];
        int area = h * (j-i);
        max = max > area ? max : area;
    }
    return max;
}

```