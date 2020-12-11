//
//  NineBigSort.m
//  NineBigSort
//
//  Created by 康永帅 on 15/7/29.
//  Copyright (c) 2015年 Liu Dehua. All rights reserved.
//

#import "NineBigSort.h"

// 交换（x, y 为同一指针时，会被置 0）
//void swap(int *x, int *y) {
//    *x ^= *y;
//    *y ^= *x;
//    *x ^= *y;
//}


void swap(int *x, int *y) {
    int tmp = *x;
    *x = *y;
    *y = tmp;
}


#pragma mark - 1.冒泡排序

// 冒泡排序
void bubbleSort(int* array, int length) {
    for(int i = 0; i < length; i++) {
        for(int j = 0; j < length-(i+1); j++) {
            if(array[j] > array[j + 1]) { // 把大的移动到最后（也可把小的移动到最前）
                swap(array+j,array+j+1);
            }
        }
    }
}

// 改进冒泡排序
void improvedBubbleSort(int* array, int length) {
    bool flag = true;
    for(int i = 0; i < length; i++) {
        if (false == flag) return;
        flag = false;
        for(int j = 0; j < length-(i+1); j++) {
            if(array[j] > array[j + 1]) {
                swap(array+j,array+j+1);
                flag = true;
            }
        }
    }
}

#pragma mark - 2.选择排序

// 选择排序
void sectionSort(int* array, int length) {
    for(int i = 0; i < length; i++) {
        int min = i;
        for (int j = i+1; j < length; j++) {
            if (array[j] < array[min]) {
                min = j;
            }
        }
        if (min != i) {
            swap(array+i,array+min);
        }
    }
}

#pragma mark - 3.插入排序

// 插入排序
void insertSort(int* array, int length) {
    for( int i = 1; i < length; i++) {
        int j = i-1;
        int key = array[i];
        while (j >= 0 && array[j] > key) {
            array[j+1] = array[j];  // 元素后移
            j--;
        }
        array[j+1]=key;
    }
}

#pragma mark - 4.希尔排序

//希尔排序
void shellSort(int* array, int length){
    for (int gap = length/2; gap > 0; gap = gap/2) {    // 分割成 gap 个组
        for (int i = gap; i < length; i++) {            // 分别进行直接插入排序（多个分组交替执行）
            int j = i-gap;
            int current = array[i];
            while (j>=0 && array[j]>current) {
                array[j+gap] = array[j];
                j = j-gap;
            }
            array[j+gap] = current;
        }
    }
}

#pragma mark - 5.归并排序

// 将有二个有序数列 a[first...mid] 和 a[mid+1...last] 合并
void mergeArray(int *a, int first, int mid, int last, int *temp) {
    int i = first, m = mid;
    int j = mid + 1, n = last;
    int k = 0;      // 记录元素个
    
    while (i<=m && j<=n) {
        (a[i] <= a[j]) ? (temp[k++] = a[i++]) : (temp[k++] = a[j++]);
    }
    
    while (i <= m) temp[k++] = a[i++];
    
    while (j <= n) temp[k++] = a[j++];
    
    for (i = 0; i < k; i++) { // 复制回原数组，这样原数组这段就是有序的了
        a[first + i] = temp[i];
    }
}

// 实现
void mergeSort(int *a, int first, int last, int *temp) {
    if (first < last) {
        int mid = (first + last) / 2;
        mergeSort(a, first, mid, temp);         // 左边排序
        mergeSort(a, mid + 1, last, temp);      // 右边排序
        mergeArray(a, first, mid, last, temp);  // 合并
    }
}

#pragma mark - 6.快速排序

int partition(int *array, int left, int right) {
    int pivot = left;
    int index = pivot + 1;
    for (int i = index; i <= right; i++) {
        if (array[i] < array[pivot]) {
            swap(array+i, array+index);
            index++;
        }
    }
    swap(array+pivot, array+index-1);
    return index-1;
}

// 快速排序
void quickSort(int *array, int left, int right) {
    if (left < right) {
        int mid = partition(array, left, right);
        quickSort(array, left, mid-1);     // 递归调用
        quickSort(array, mid+1, right);
    }
}

#pragma mark - 7.堆排序

// 向下调整

// 非递归实现
// array 是待调整的堆数组，i是待调整的数组元素的位置，nlength是数组的长度
// 本函数功能是：根据数组array构建大根堆
void heapDownAdjust(int array[],int i,int nLength) {
    int nChild;
    while(2*i+1 < nLength) {
        nChild = 2*i+1;                 // 左孩子（2*（父节点位置）+ 1）
        if(nChild<nLength-1 && array[nChild+1]>array[nChild])
            ++nChild;                   // 得到子节点中较大的节点
        if(array[i] >= array[nChild]) {
            break;
        }
        swap(array+i,array+nChild);     // 较大子节点大于父节点向上移动
        i=nChild;
    }
}

// 递归实现
void heapDownRecursiveAdjust(int array[],int i,int nLength) {
    int nChild;
    if (2*i+1 < nLength) {
        nChild = 2*i+1;   // 左孩子（2*（父节点位置）+ 1）
        if((nChild < nLength-1) && (array[nChild+1] > array[nChild])) // 得到子节点中较大的节点
            ++nChild;
        if(array[i] < array[nChild]){
            swap(array+i,array+nChild);
            heapDownRecursiveAdjust(array, nChild, nLength);
        }
    }
}

// 向上调整
// 非递归实现
void heapUpAdjust(int *array, int index, int nLength) {
    int i = index;
    int j = (i-1)/2;            // 父节点
    int temp = array[i];
    while(i > 0){
        if(temp <= array[j]) break;
        array[i] = array[j];    // 比交换高明
        i = j;
        j = (j-1)/2;            // 移动到下一节点
    }
    array[i] = temp;
}

// 递归实现
void heapUpRecursiveAdjust(int array[], int index, int nLength) {
    int i = index;
    int j = (i-1)/2;
    if(i > 0){
        if(array[i] <= array[j]) return;
        swap(array+i, array+j);
        heapUpRecursiveAdjust(array, j, nLength);
    }
}


// 创建堆
void createHeap(int *array,int length) {
    int i;
    // 调整序列的前半部分元素，调整完之后第一个元素是序列的最大的元素
    // length/2-1 是最后一个非叶节点，此处"/"为整除
    for(i = length/2-1; i >= 0; --i)
        heapDownAdjust(array,i,length);
        //heapDownRecursiveAdjust(array,0,i);
}

// 插入元素
int insertElement(int *array, int length, int element) {
    if (length) {
        array[length] = element;  // 放入元素，这里注意数组长度要大于length+1
        ++length;
        heapUpAdjust(array, length-1, length);
        //heapUpRecursiveAdjust(array, length-1, length);
        return length;
    }
    return -1;
}

// 删除堆元素（堆只能删除根元素）
int deleteElement(int *array, int length) {
    if (length) {
        swap(array,array+length-1);         // 根节点与最后一个节点交换
        heapDownAdjust(array,0,length-1);   // 向下交换
        return length-1;
    }
    return 0;
}

// 堆排序算法（传入 array 已是堆）
void heapSort(int *array,int length) {
    int i;
    //从最后一个元素开始对序列进行调整，不断的缩小调整的范围直到第一个元素
    for(i = length-1; i > 0; --i) {
        // 把第一个元素和当前的最后一个元素交换，
        // 保证当前的最后一个位置的元素都是在现在的这个序列之中最大的
        swap(array,array+i);
        heapDownAdjust(array,0,i); // 不断缩小范围，每一次调整完毕第一个元素是当前序列的最大值
        // heapDownRecursiveAdjust(array,0,i);
    }
}

#pragma mark - 8.计数排序

// 计数排序
void countSort(int *input, int *output, int length, int k) {// 时间复杂度为Ο(n+k)（其中k是整数的范围）
    // input为输入数组，output为输出数组，length表示数组长度，k表示有所输入数字都介于0到k之间
    int C[k+1], i, value, pos;
    for(i = 0; i <= k; i++) {       // 初始化
        C[i] = 0;
    }
    
    //检查每个输入元素，如果一个输入元素的值为input[i],那么c[input[i]]的值加1，此操作完成后，c[i]中存放了值为i的元素的个数
    for(i = 0; i < length; i++) {
        C[input[i]] ++;
    }
    
    // 通过在c中记录计数和，c[i] 中存放的是小于等于i元素的数字个数
    for(i=1; i<=k; i++) {
        C[i] = C[i] + C[i-1];
    }
    
    // 从后往前遍历
    for(i=length-1; i>=0; i--) {
        value = input[i];
        pos = C[value];
        output[pos-1] = value;
        C[value]--;// 该操作使得下一个值为input[i]的元素直接进入输出数组中input[i]的前一个位置
    }
}


#pragma mark - 9.基数排序

// 找到num的从低到高的第pos位的数据
int getNumInPosition(int num,int pos) {
    int temp = 1;
    for (int i = 0; i < pos - 1; i++)
        temp *= 10;
    return (num / temp) % 10;
}

// 基数排序
#define RADIX_10 10      // 正整形排序
#define KEYNUM_31 10     // 正整形位数
void radixSort(int* array, int length) { // 时间复杂度 O(dn) (d即表示最高位数)
    //length表示数组长度
    int *radixArrays[RADIX_10];     // 分别为 0~9 的序列空间
    for (int i = 0; i < 10; i++) {
        radixArrays[i] = (int *)malloc(sizeof(int) * (length + 1));
        radixArrays[i][0] = 0;      // index 为 0 处记录这组数据的个数
    }
    
    for (int pos = 1; pos <= KEYNUM_31; pos++) {
        // 分配过程
        for (int i = 0; i < length; i++) {
            int num = getNumInPosition(array[i], pos);
            int index = ++radixArrays[num][0];
            radixArrays[num][index] = array[i];
        }
        
        // 收集
        for (int i = 0, j =0; i < RADIX_10; i++) {
            for (int k = 1; k <= radixArrays[i][0]; k++)
                array[j++] = radixArrays[i][k];
            radixArrays[i][0] = 0;    // 复位
        }
    }
}
