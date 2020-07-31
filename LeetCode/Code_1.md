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


## 5.两两交换链表中的节点（Leetcode 24）

```
// C

/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     struct ListNode *next;
 * };
 */


struct ListNode* swapPairs(struct ListNode* first){
    if (NULL == first) return NULL;
    struct ListNode *head = (struct ListNode *)malloc(sizeof(struct ListNode));
    head->next = first;

    struct ListNode *pre = head; 
    struct ListNode *current = head->next;
    while (current && current->next) {
        struct ListNode *next = current->next;

        pre->next = next;
        current->next = next->next;
        next->next = current;

        pre = current;
        current = current->next;
    }
    return head->next;
}

```

## 5.括号生成（Leetcode 22）


```
// C

/**
 * Note: The returned array must be malloced, assume caller calls free().
 */

int catelan(int n) {
    int i, j, h[n+1];
    h[0] = h[1] = 1;
    for (int i = 2; i <= n; i++) {
        h[i] = 0;
        for (int j = 0; j < i; j ++){
            h[i] = h[i] + h[j]*h[i-j-1];
        }
    }
    return h[n];
}

void dfs(char *s, int left, int right, int n, char **result, int *returnSize) {
    if (left == n && right == n) {
        result[*returnSize] = (char **)malloc(sizeof(int) * (2*n+1));
        memcpy(result[*returnSize], s, sizeof(char) * (2*n+1));
        (*returnSize) ++;
        return;
    }
    int index = left + right;
    if (left < n) {
        s[index] = '(';
        dfs(s, left+1, right, n, result, returnSize);
    }
    if (right < left) {
        s[index] = ')';
        dfs(s, left, right+1, n, result, returnSize);
    }
}

char ** generateParenthesis(int n, int* returnSize){
    if (0 == n) return NULL;
    int total = catelan(n);
    char *s = (char *)calloc((2 * n + 1), sizeof(char));
    char **result = (char **)malloc(sizeof(char *) * total);
    *returnSize = 0;
    dfs(s, 0, 0, n, result, returnSize);
    return result;
}

```

## 6.全排列（Leetcode 46）

```
// C

/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the arrays are returned as *returnColumnSizes array.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */

void dfs(int* nums, int numsSize, int *used, int *path, int current, int **result, int* returnSize, int** returnColumnSizes) {
    if (current == numsSize) {
        result[*returnSize] = (int *)malloc(sizeof(int) * numsSize); 
        memcpy(result[*returnSize], path, sizeof(int) * numsSize);
        (*returnColumnSizes)[*returnSize] = numsSize;
        (*returnSize) ++;
        return;
    }
    for (int i = 0; i < numsSize; i++) {
        if (0 == used[i]) {
            used[i] = 1;
            path[current] = nums[i];
            dfs(nums, numsSize, used, path, current+1, result, returnSize, returnColumnSizes);
            used[i] = 0;
        }
    }   
}

int** permute(int* nums, int numsSize, int* returnSize, int** returnColumnSizes){
    if (NULL == nums) return NULL;

    // 计算总数
    int total = 1;
    for (int i = 2; i <= numsSize; i++) {
        total *= i;
    }

    // 初始化入参
    int path[numsSize];
    int used[numsSize];
    memset(used, 0, sizeof(int) * numsSize);
    int **result = (int **)malloc(sizeof(int *) * total);
    *returnSize = 0;
    *returnColumnSizes = (int *)malloc(sizeof(int) * total); 

    // 进入函数
    dfs(nums, numsSize, used, path, 0, result, returnSize, returnColumnSizes);

    return result;
}

```


## 7.全排列 II（Leetcode 47）

```
// C

/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the arrays are returned as *returnColumnSizes array.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */

int comp(const void*a, const void*b) {
    return *(int*)a-*(int*)b;
}

void dfs(int* nums, int numsSize, int *used, int *path, int current, int **result, int* returnSize, int** returnColumnSizes) {
    if (current == numsSize) {
        result[*returnSize] = (int *)malloc(sizeof(int) * numsSize); 
        memcpy(result[*returnSize], path, sizeof(int) * numsSize);
        (*returnColumnSizes)[*returnSize] = numsSize;
        (*returnSize) ++;
        return;
    }
    for (int i = 0; i < numsSize; i++) {
        if (i > 0 && nums[i] == nums[i-1] && 0 == used[i-1]) continue;
        if (0 == used[i]) {
            used[i] = 1;
            path[current] = nums[i];
            dfs(nums, numsSize, used, path, current+1, result, returnSize, returnColumnSizes);
            used[i] = 0;
        }
    }   
}

int** permuteUnique(int* nums, int numsSize, int* returnSize, int** returnColumnSizes){
    if (NULL == nums) return NULL;

    // 排序
    qsort(nums, numsSize, sizeof(int), comp);

    // 计算总数
    int total = 1;
    for (int i = 2; i <= numsSize; i++) {
        total *= i;
    }

    // 初始化入参
    int path[numsSize];
    int used[numsSize];
    memset(used, 0, sizeof(int) * numsSize);
    int **result = (int **)malloc(sizeof(int *) * total);
    *returnSize = 0;
    *returnColumnSizes = (int *)malloc(sizeof(int) * total); 

    // 进入函数
    dfs(nums, numsSize, used, path, 0, result, returnSize, returnColumnSizes);

    return result;
}

```

## 8.二叉树中序遍历（Leetcode 94）

```
// C++

/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     TreeNode *left;
 *     TreeNode *right;
 *     TreeNode(int x) : val(x), left(NULL), right(NULL) {}
 * };
 */
class Solution {
public:
    vector<int> inorderTraversal(TreeNode* root) {
        stack<TreeNode *> stack;
        vector<int> result;
        TreeNode *p = root;
        while (p || !stack.empty()){
            if (p){
                stack.push(p);
                p = p->left;
            } else {
                p = stack.top();
                result.push_back(p->val);
                stack.pop();
                p = p->right;
            }
        }
        return result;
    }
};

```

## 9.从前序与中序遍历序列构造二叉树（Leetcode 105）

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

struct TreeNode* buildTree(int* preorder, int preorderSize, int* inorder, int inorderSize) {
    // 结束条件
    if (0 == preorderSize || 0 == inorderSize) return NULL;
    if (NULL == preorder || NULL == inorder) return NULL;
    if (preorderSize != inorderSize) return NULL;

    // 计算左右子树个数
    int rootVal = preorder[0];
    int leftNum = 0;
    for (; leftNum < inorderSize; leftNum ++) {
        if (rootVal == inorder[leftNum]) break;
    }
    int rightNum = inorderSize - leftNum - 1;

    // 初始化节点
    struct TreeNode *rootNode = (struct TreeNode *)malloc(sizeof(struct TreeNode));
    memset(rootNode, 0, sizeof(struct TreeNode));

    // 递归
    rootNode->val = rootVal;
    rootNode->left = buildTree(preorder+1, leftNum, inorder, leftNum);
    rootNode->right = buildTree(preorder+(leftNum+1), rightNum, inorder+(leftNum+1), rightNum);
    
    return rootNode;
}
```

## 10.岛屿数量（Leetcode 200）

```
// C

void dfs(char** grid, int gridSize, int* gridColSize, int i, int j) {
    if(i<0 || i>=gridSize || j<0 || j>=gridColSize[i] || '1'!=grid[i][j]) return;
    grid[i][j] = '0';
    dfs(grid, gridSize, gridColSize, i+1, j);
    dfs(grid, gridSize, gridColSize, i-1, j);
    dfs(grid, gridSize, gridColSize, i, j+1);
    dfs(grid, gridSize, gridColSize, i, j-1);
}

int numIslands(char** grid, int gridSize, int* gridColSize){
    if(grid==NULL || gridSize == 0 || gridColSize==NULL) return 0;

    int count = 0;
    for(int i=0; i<gridSize; i++) {
        for(int j = 0; j<gridColSize[i]; j++) {
            if('1' == grid[i][j])
                count ++;
                dfs(grid, gridSize, gridColSize, i, j);
        }
    }
    return count;
}

```

## 10.二叉树的层序遍历（Leetcode 102）

```
// C++

/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     TreeNode *left;
 *     TreeNode *right;
 *     TreeNode(int x) : val(x), left(NULL), right(NULL) {}
 * };
 */
class Solution {
public:
    vector<vector<int>> levelOrder(TreeNode* root) {
        vector<vector<int>> result;
        if (!root) return result;
        queue<TreeNode*> q;    // 队列
        q.push(root);
        while (!q.empty()) {
            int currentLevelSize = q.size();              // 当前层全部节点数
            result.push_back(vector<int>());              // vector<int> 存放当前层全部节点
            for (int i = 1; i <= currentLevelSize; ++i) { // 取出当前层全部节点放入 vector<int>
                auto node = q.front(); // 队列头节点
                q.pop();               // 移出队列头节点
                result.back().push_back(node->val);
                if (node->left) q.push(node->left);
                if (node->right) q.push(node->right);
            }
        }
        
        return result;
    }
};
```

## 11.买卖股票的最佳时机 II（Leetcode 122）

```
// C

int maxProfit(int* prices, int pricesSize){
    if (pricesSize<=1) return 0;
    int total = 0;
    for (int i=0; i<pricesSize-1; i++) {
        if (prices[i+1] > prices[i]) {
            total += (prices[i+1] - prices[i]);
        }
    }
    return total;
}

```

## 12.搜索旋转排序数组（Leetcode 33）

```
// C

int search(int* nums, int numsSize, int target){
    if (0 == numsSize) return -1;
    int low = 0;
    int high = numsSize-1;
    while (low <= high) {
        int mid = (low + high) / 2;
        if (nums[mid] == target) return mid;
        if (nums[0] <= nums[mid] ) {
            (nums[0]<=target && nums[mid]>target) ? (high=mid-1) : (low=mid+1);
        } else {
            (nums[mid]<target && nums[numsSize-1]>=target) ? (low=mid+1) : (high=mid-1);
        }
    }
    return -1;
}

```
## 13.四数之和（Leetcode 18）

```
// C++

class Solution {
public:
    vector<vector<int>> fourSum(vector<int>& nums, int target) {
        vector<vector<int> > result; 
        int numSize = nums.size();
        if (numSize < 4) return result;      
        sort(nums.begin(), nums.end());                         // 排序
        for(int a = 0; a <= numSize-4; a++){
            if(a > 0 && nums[a] == nums[a-1]) continue;         // 跳过相同的 a
            for(int b = a+1; b <= numSize-3; b++){
                if(b > a+1 && nums[b] == nums[b-1]) continue;   // 跳过相同的 b
                int ab = nums[a] + nums[b];          
                int c = b + 1;
                int d = numSize - 1;
                while(c < d){
                    int abcd = ab + nums[c] + nums[d]; 
                    if (abcd == target) {
                        result.push_back({nums[a],nums[b],nums[c],nums[d]});
                        c++;
                        d--;
                        while(c < d && nums[c] == nums[c-1]) c++;
                        while(c < d && nums[d] == nums[d+1]) d--;
                    } else {
                       abcd < target ? c++ : d--;   // 小于 c 右移，大于 d 左移
                    } 
                }
            }
        }
        return result;
    }
};

```

## 14.跳跃游戏 II（Leetcode 45）

```
// C

int jump(int* nums, int numsSize){
    if(NULL == nums) return NULL;
    int jumpCount = 0;
    int end = numsSize - 1;
    while (end >= 0) {
        int current = end;
        for (int i = end-1; i>=0; i--) { // 找到最靠前并且能到达当前 end 的 index
            if (i + nums[i] >= end) current = i;  
        }
        if (current == end) break;
        end = current;                   // 更新 end
        jumpCount ++;
    }
    return jumpCount;
}

```
