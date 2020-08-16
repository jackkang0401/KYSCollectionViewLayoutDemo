# Code_2


## 1.解码方法（Leetcode 91）

```
// C++

class Solution {
public:
    int numDecodings(string s) {
        if (0 == s.size() || '0' == s[0]) return 0;
        int size = s.size();
        vector<int> dp(size + 1);
        dp[0] = dp[1] = 1;
        for (int i = 1; i < size; i++) {
            if ('0' == s[i]) {  // 当前位置为 0，上一位置是 1 或 2 才可以解码
                if (!('1' == s[i-1] || '2' == s[i-1])) return 0;
                dp[i+1] = dp[i-1];
            } else if (s[i] <= '6') {
                dp[i+1] = dp[i] + (('1' == s[i-1] || '2' == s[i-1]) ? dp[i-1] : 0);
            } else {
                dp[i+1] = dp[i] + (('1' == s[i-1]) ? dp[i-1] : 0);
            }
        }
        return dp[size];
    }
};

```

## 2.回文子串（Leetcode 647）

```
// C++

// 1.中心扩展法

class Solution {
public:
    int countSubstrings(string s) {
        int length = s.length();
        int total = 0;
        for(int i = 0, count = length*2; i < count; i++){
            // 长度分别为奇数（s[i]）、偶数（中心为空）的回文子串
            int left = i / 2;
            int right = left + i % 2;
            // 向外扩张
            while(left >= 0 && right < length && s[left] == s[right]){
                left--;
                right++;
                total++;
            }
        }
        return total;
    }
};

```

## 3.实现 Trie (前缀树)（Leetcode 208）

```
// C++

class Trie {

private:
    bool isEnd;
    Trie* links[26];
    
public:    
    // 初始化
    Trie() {
        isEnd = false;
        for (int i = 0; i < 26; i++) {
            links[i] = nullptr;
        }
    }

    // 析构
    ~Trie() {
        for (int i = 0; i < 26; i++) {
            if (links[i] == nullptr) continue;
            delete(links[i]);
            links[i] = nullptr;
        }
    }
    
    // 插入单词
    void insert(string word) {
        Trie *node = this;
        for (auto c : word) {
            int i = c - 'a';
            if (node->links[i] == nullptr) node->links[i] = new Trie();
            node = node->links[i];
        }
        node->isEnd = true;
    }
    
    // 查找单词
    bool search(string word) {
        Trie *node = this;
        for (auto c : word) {
            int i = c - 'a';
            if (node->links[i] == nullptr) return false;
            node = node->links[i];
        }
        return node->isEnd;
    }
    
    // 查找前缀
    bool startsWith(string prefix) {
        Trie *node = this;
        for (auto c : prefix) {
            int i = c - 'a';
            if (node->links[i] == nullptr) return false;
            node = node->links[i];
        }
        return true;
    }
};

/**
 * Your Trie object will be instantiated and called as such:
 * Trie* obj = new Trie();
 * obj->insert(word);
 * bool param_2 = obj->search(word);
 * bool param_3 = obj->startsWith(prefix);
 */
 
```

## 4.单词搜索 II（Leetcode 212）

```
class Trie {
private:
    bool isEnd;
    Trie* links[26];

public:
    // 初始化
    Trie() {
        isEnd = false;
        for (int i = 0; i < 26; i++) {
            links[i] = nullptr;
        }
    }

    // 析构
    ~Trie() {
        for (int i = 0; i < 26; i++) {
            if (nullptr == links[i]) continue;
            delete(links[i]);
            links[i] = nullptr;
        }
    }

    // 插入
    void insert(string word) {
        Trie *node = this;
        for (auto c : word) {
            int i = c - 'a';
            if (nullptr == node->links[i]) node->links[i] = new Trie();
            node = node->links[i];
        }
        node->isEnd = true;
    }

    // 查找
    bool search(string word) {
        Trie *node = this;
        for (auto c : word) {
            int i = c - 'a';
            if (nullptr == node->links[i]) return false;
            node = node->links[i];
        }
        return node->isEnd;
    }

    // 查找前缀
    bool startWith(string prefix) {
        Trie *node = this;
        for (auto c : prefix) {
            int i = c - 'a';
            if (nullptr == node->links[i]) return false;
            node = node->links[i];
        }
        return true;
    }

    // 查找 board
    void searchFromBoard(vector<string>& result, vector<vector<char>>& board) {
        for (int i = 0, rowSize = board.size(); i < rowSize; i++) {
            for (int j = 0, colSize = board[i].size(); j < colSize; j++) {
                string word;
                dfs(result, board, this, i, j, word);
            }
        }
    }

    // 遍历 board
    void dfs(vector<string>& result, vector<vector<char>>& board, Trie* node, int x, int y, string& word) {
        if (node->isEnd) {
            node->isEnd = false;
            result.push_back(word);
            return;
        }
        if (x < 0 || x == board.size() || y < 0 || y == board[x].size()) return;
        char c = board[x][y];
        if ('#' == c) return;                   // 当前字符已使用过
        int i = c - 'a';
        if (nullptr == node->links[i]) return;  // 当前字符不存在

        node = node->links[i];
        word.push_back(c);
        board[x][y] = '#';
        dfs(result, board, node, x+1, y, word);
        dfs(result, board, node, x-1, y, word);
        dfs(result, board, node, x, y+1, word);
        dfs(result, board, node, x, y-1, word);
        board[x][y] = c;
        word.pop_back();
    }
};

class Solution {
public:
    vector<string> findWords(vector<vector<char>>& board, vector<string>& words) {
        Trie trie;
        vector<string> result;
        for (string& w : words) {
            trie.insert(w);
        }
        trie.searchFromBoard(result, board);
        return result;
    }
};

```

## 5.解数独（Leetcode 37）

```
// C++

class Solution {
public:
    void solveSudoku(vector<vector<char>>& board) {
        if (0 == board.size() || 0 == board[0].size()) return;
        solve(board);
    }

private:
    bool solve(vector<vector<char>>& board) {
        for (int i = 0, rowSize = board.size(); i < rowSize; i++) {
            for (int j = 0, colSize = board[i].size(); j < colSize; j++) {
                if ('.' != board[i][j]) continue;
                for (char c = '1'; c <= '9'; c++) {
                    if (isValid(board, i, j, c)) {
                        board[i][j] = c;
                        if (solve(board)) return true;
                        board[i][j] = '.';
                    }
                }
                return false;
            }
        }
        return true;
    }

    bool isValid(vector<vector<char>>& board, int row, int col, char c) {
        for (int i = 0; i < 9; i++) {
            if (board[i][col] != '.' && board[i][col] == c) return false;
            if (board[row][i] != '.' && board[row][i] == c) return false;
            int boxI = 3*(row/3) + i/3;
            int boxJ = 3*(col/3) + i%3;
            if (board[boxI][boxJ] != '.' && board[boxI][boxJ] == c) return false;
        }
        return true;
    }
};

```

```
// C++

// 优化：每次递归起点都是下一个，不再是从头开始判断

class Solution {
public:
    void solveSudoku(vector<vector<char>>& board) {
        if (0 == board.size() || 0 == board[0].size()) return;
        solve(board, board.size(), 0); // 每次递归起点都是下一个
    }

private:
    bool solve(vector<vector<char>>& board, int size, int current) {
        for (int k = current, total = size*size; k < total; k++) {
            int i = k / size, j = k % size;
            if ('.' != board[i][j]) continue;
            for (char c = '1'; c <= '9'; c++) {
                if (isValid(board, i, j, c)) {
                    board[i][j] = c;
                    if (solve(board, size, k+1)) return true;
                    board[i][j] = '.';
                }
            }
            return false;
        }
        return true;
    }

    bool isValid(vector<vector<char>>& board, int row, int col, char c) {
        for (int i = 0; i < 9; i++) {
            if (board[i][col] != '.' && board[i][col] == c) return false;
            if (board[row][i] != '.' && board[row][i] == c) return false;
            int boxI = 3*(row/3) + i/3;
            int boxJ = 3*(col/3) + i%3;
            if (board[boxI][boxJ] != '.' && board[boxI][boxJ] == c) return false;
        }
        return true;
    }
};

```

## 6.求1+2+…+n（剑指 Offer 64）

```
class Solution {
public:
    int sumNums(int n) {
        int ans = 0, A = n, B = n + 1;
        
        /*
        while (B) {
            if (B & 1) ans += A;
            A <<= 1;
            B >>= 1;
        }
        return ans >> 1;
        */
        
        (B & 1) && (ans += A); A <<= 1; B >>= 1; // 1
        (B & 1) && (ans += A); A <<= 1; B >>= 1; // 2
        (B & 1) && (ans += A); A <<= 1; B >>= 1; // 3
        (B & 1) && (ans += A); A <<= 1; B >>= 1; // 4
        (B & 1) && (ans += A); A <<= 1; B >>= 1; // 5
        (B & 1) && (ans += A); A <<= 1; B >>= 1; // 6
        (B & 1) && (ans += A); A <<= 1; B >>= 1; // 7
        (B & 1) && (ans += A); A <<= 1; B >>= 1; // 8
        (B & 1) && (ans += A); A <<= 1; B >>= 1; // 9
        (B & 1) && (ans += A); A <<= 1; B >>= 1; // 10
        (B & 1) && (ans += A); A <<= 1; B >>= 1; // 11
        (B & 1) && (ans += A); A <<= 1; B >>= 1; // 12
        (B & 1) && (ans += A); A <<= 1; B >>= 1; // 13
        (B & 1) && (ans += A); A <<= 1; B >>= 1; // 14
        return ans >> 1; // (n * (n + 1)) / 2
    }
};

```

## 7.N皇后（Leetcode 51）

```
// C++
// 回溯 方法一

class Solution {
public:
    vector<vector<string>> solveNQueens(int n) {
        vector<vector<int>> result;
        vector<int> currentState(n, -1);    // 下标代表皇后所在行，值代表列
        set<int> cols;                      // '|' 列
        set<int> slashs;                    // '/' row + column
        set<int> backslashs;                // '\' row - column
        dfs(n, 0, cols, slashs, backslashs, currentState, result);
        return generateResult(n, result);
    }

private:
    void dfs(int n, int row, set<int> &cols, set<int> &slashs, set<int> &backslashs, vector<int> &currentState, vector<vector<int>> &result) {
        if (row >= n) {
            result.push_back(currentState);
            return;
        }
        for (int col = 0; col < n; col++) {
            if (hasContain(row, col, cols, slashs, backslashs)) continue;
            cols.insert(col);
            slashs.insert(row + col);
            backslashs.insert(row - col);

            currentState[row] = col; 
            dfs(n, row + 1, cols, slashs, backslashs, currentState, result);
            currentState[row] = -1; // 这行可以省略，后续会直接替换该位置

            cols.erase(col);
            slashs.erase(row + col);
            backslashs.erase(row - col);
        }
    }

    // 检测是否发生冲突
    bool hasContain(int row, int col, set<int> &cols, set<int> &slashs, set<int> &backslashs) {
        if (cols.find(col) != cols.end() || 
            slashs.find(row + col) != slashs.end() ||
            backslashs.find(row - col) != backslashs.end()) {
            return true;
        }
        return false;
    }

    // 生成结果
    vector<vector<string>> generateResult(int n, vector<vector<int>> result) {
        vector<vector<string>> generateResult;
        for (int i = 0, size = result.size(); i < size; i++) {
            vector<int> currentState = result[i];
            vector<string> currentStateStr(n, string(n, '.'));
            for (int j = 0, curSize = currentState.size(); j < curSize; j++) {
                currentStateStr[j][currentState[j]] = 'Q';
            }
            generateResult.push_back(currentStateStr);
        }
        return generateResult;
    }
};

```
