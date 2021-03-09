# Code_5


## 1.验证回文字符串 Ⅱ（Leetcode 680）

```

// C++
// 贪心

class Solution {
public:
    bool validPalindrome(string s) {
        int low = 0, high = s.size() - 1;
        while (low < high) {
            char c1 = s[low], c2 = s[high];
            if (c1 == c2) {
                ++low;
                --high;
            } else {
                return checkPalindrome(s, low, high - 1) || checkPalindrome(s, low + 1, high);
            }
        }
        return true;
    }

private:
    bool checkPalindrome(const string &s, int low, int high) {
        for (int i = low, j = high; i < j; ++i, --j) {
            if (s[i] != s[j]) {
                return false;
            }
        }
        return true;
    }
};

```


## 2.有效的字母异位词（Leetcode 242）


```

// C++
// hash 表（也可排序比较，耗时较长）

class Solution {
public:
    bool isAnagram(string s, string t) {
        if (s.length() != t.length()) return false;
        vector<int> hashTable(26, 0);
        for (auto &c : s) {
            hashTable[c-'a'] ++;
        }
        for (auto &c : t) {
            hashTable[c-'a'] --;
            if (hashTable[c-'a'] < 0) return false;
        }
        return true;
    }
};

```

## 3.字母异位词分组（Leetcode 49）


```

// C++
// hash 表

class Solution {
public:
    vector<vector<string>> groupAnagrams(vector<string>& strs) {
        unordered_map<string, vector<string>> resultMap;
        for (string s : strs) {
            vector<int> hashTable(26, 0);
            int length = s.length();
            for (auto &c : s) {
                hashTable[c-'a'] ++;
            }
            string key = "key_";
            for (int i = 0; i < 26; i++) {
                if (hashTable[i] > 0) {
                    key += ('a'+i);
                    key += to_string(hashTable[i]);
                }
            }
            resultMap[key].push_back(s);
        }
        vector<vector<string>> result;
        for (unordered_map<string, vector<string>>::iterator it = resultMap.begin(); it != resultMap.end(); it++ ) {
            result.push_back(it->second);
        }
        return result;
    }
};


```
