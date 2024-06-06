## - 指针

```c++
int* p = &val;
int* p = nullptr;
```

### 关于`nullptr`

> 一个特殊的对象（类型为`nullptr_t`），表示空指针
>
> 类似C中的NULL，但更加安全

### 指针与`bool`的隐式转换

> 非空指针可以转换为true，空指针可以转换为false

```c++
int* p = nullptr;
if(p){
    
}else{
    
}
```

### `void*`指针

> 没有记录对象的尺寸信息，可以保存任意地址
>
> 支持判等操作

### 指针 vs 对象

> 间接引用
>
> 指针复制成本低，读写成本高
>
> 函数调用时，传入参数使用复制逻辑，使用传入指针可以降低复制成本
>
> 根据指针的原理可以改变外面传入参数的值

```c++
struct Str{
    // ...
}

void func(Str* param){
    // ...
}
int main(){
    Str str;
    Str* p = &str;
    func(p);
    reutnr 0;
}
```

### 指针的问题

> 可以为空
>
> 地址信息可能非法，行为不可控，解决方案：引用

## - 引用

```c++
int& ref = val;

int x = 3;
int& ref = x;
std::cout << ref << std::endl;  // 3
ref = ref + 1;
std::cout << x << std::endl;	// 4
```

### 引用的特性

> 它是对象的别名，不能绑定字面值 `int& ref = 3;`

> 构造时绑定对象（错误：int& ref;），在其生命周期内不能绑定其它对象（赋值操作会改变对象内容）

```c++
int x = 3;
int& ref = x;
int y = 0;
ref = y;	// 此时相当于x=y，并没有将ref重新绑定到y的别名（与指针不同）
```

> 不存在空引用，但可能存在非法引用--总的来说比指针安全

```c++
int& func(){
    int x;
    int& ref = x;
    return ref;
}
int main(){
    int& res = func();  // 非法引用了一个销毁的对象
}
```

> 属于编译期概念，在底层还是通过指针实现

### 指针的引用

> 指针时对象，因此可以定义引用

```c++
int* p = &val;
// int*& 类型信息从有到左解析，首先它是一个引用，引用的类型的int*
int*& ref = p;
```

> 没有引用的引用

## -常量

### 常量指针

```c++
int* const ptr = &x;
const int* ptr = &x;
const int* const ptr = &x;
```

> const在*的右边 --> 指针ptr不能修改（不能改变指向）
>
> const在*的左边--> 指针ptr指向的内容不能修改

> 可以 int* 隐式转换为 const int*，反之不能
>
> ```c++
> // 合法
> int x = 3;
> const int* ptr = &x;
> 
> // 下面编译器会报错，原因：const常量的逻辑就是保证常量不被修改，如果int* ptr = &x合法那么我们就可以通过指针修改x的值，这显然和常量的定义是违背的，所以编译器会报错
> const int x = 3;
> int* ptr = &x;  // 非法
> const int* = &x; // 合法
> ```
>
> 

### 常量引用

```c++
int x = 3;
const int& ref = x;
```

#### 常量引用存在场景

```c++
struct Str{
    // ...
};
void func(Str param){
    // ...
};
int main(){
    Str x;
    // 如果某种场景结构体变量x不支持拷贝和修改，或者拷贝成本太高时，直接传x就不符合要求了
    func(x);
}

// 修改版：
struct Str{
    // ...
};
// 使用常量引用满足要求 
void func(const Str& param){
    // ...
};
int main(){
    Str x;
    func(x);
}
```

## - 类型别名

```c++
// 两种引入类型别名的方式
typedef int myInt;
using myInt = int; // since c++11
```

> 使用using引入类型别名的方式更友好
>
> ```c++
> typedef char MyCharArr[4];
> using MyCharArr = char[4];
> ```

## - 类型的自动推导

> 从C++11开始，可以通过初始化表达式自动推导对象类型
>
> 自动推导类型对象依然时强类型

### 自动推导几种常见形式

#### `auto`

> 最常用的形式，但可能会产生类型退化
>
> - 类型退化的一种理解：当变量A作为右值赋值给另一个变量B时，A的类型会退化成B的一种情况
>
>   ```c++
>   int x = 3;
>   int& ref = x;
>   int ref1 = ref;  // int& -> int
>   ```
>
> - auto的类型退化例子
>
>   ```c++
>   int x = 3;
>   int& ref = x;
>   auto ref1 = ref;  // 这里左边的ref1并不是int&而是会退化成int
>   
>   const int y = 3;
>   auto z = y; // -> int, const int y作为右值使用时，会退化为int，所以z类型为int
>   ```

#### `const auto / constexpr auto`

> 推导出的时常量 或者常量表达式类型

```c++
const auto x = 3; // -> const int
constexpr auto y = 3; // -> const int
```

#### `auto&`

> 推导出的引用类型，避免类型退化

```c++
const auto& x = 3; // -> const int&

const int y = 3;
auto& z = y; // ->const int&,注意此时使用auto&可以避免退化发生，所以z的类型时const int&而不是int&
```

#### `decltype(exp)`

> 返回exp表达式的类型 ，`decl->declare`
>
> 如果表达式（不是一个变量）是一个左值，则会变成一个引用类型

```c++
decltype(3.5 + 10l) res = 3.5 + 10l // decltype(3.5 + 10l)返回表达式3.5 + 10l结果类型
    
int x = 3;
int& y1 = x;

auto y2 = y1; // -> int
decltype(y1) y3 = y1; -> int&
    
int x = 3;
int* ptr = &x;
decltype(*ptr) y = x; // *ptr是指针解引用，一个表达式，不是变量，则推导为int&
```

#### `decltype(val)`

> 返回变量val的类型

#### `decltype(auto)`

> 从c++14开始支持简化`decltype`使用

```c++
decltype(auto) x = 3.5 + 15l;  // 防止类型退化，相当于简化decltype(3.5 + 15l) x = 3.5 + 15l;
```

#### `concept auto`

> 从c++20开始支持，表示一系列类型（`std::integral auto x = 3;`)
>
> 限制自动类型推导的范围，限制在一个大类型中，比如int long unsigned int long long是一个concept

```c++
// 注意此特性从c++20开始支持
std::integral auto y = 3; // -> int
std::integral auto z = 3.5; // 编译报错，因为z的类型被限制在integral类型范围内，一个double类型无法推导成integral
```

## - 数组

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

