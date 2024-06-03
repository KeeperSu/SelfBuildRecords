# array

#### 数组指针、指针数组

```c++
#include <iostream>

void StudyArr::run() {
    // 指针数组：arr类型int*[3]，数组元素类型为指针
    int a = 1;
    int b = 2;
    int c = 3;
    int* arr[3] = {&a, &b, &c};
    std::cout << "Result: " << std::is_same_v<decltype(arr), int*[3]> << std::endl;
    auto d = arr[1];
    std::cout << "Result: " << std::is_same_v<decltype(d), int*> << std::endl;
    // 数组指针：arr_1类型int(*)[3]，表示arr_1是一个数组的指针
    int e[3] = {4, 5, 6};
    int (*arr_1)[3] = &e;
    std::cout << "Result: " << std::is_same_v<decltype(arr_1), int(*)[3]> << std::endl;
    // 等价于auto f = arr_1
    auto f = arr_1[0]; 
    std::cout << "Result: " << std::is_same_v<decltype(f), int*> << std::endl;
    auto g = *arr_1[0]; // 指针解引用
    std::cout << "Result: " << std::is_same_v<decltype(g), int> << std::endl;

}
```



