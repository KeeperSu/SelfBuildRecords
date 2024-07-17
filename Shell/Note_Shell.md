# Linux Shell语法记录

## if 多个判断

### 1. if几种结构示例

> **注意：条件表达式的左右都要有空格**

- ```shell
  # 获取当前文件目录绝对路径
  CUR_DIR=$(cd `dirname $0`; pwd)
  echo ${CUR_DIR}
  # struct 1
  if [ -d ${CUR_DIR} ]; then
      # do something 1
  fi
  # struct 2
  if [ ! -d ${CUR_DIR} ]; then 
      # do something 1
  else 
      # do something 2
  fi
  # struct 3
  if [ ! -d ${CUR_DIR} ]; then
     # do something 1
  elif [ -f ${CUR_DIR}/build.sh ]; then
     # do something 2
  else
     # do something 3
  fi
  ```

### 2. 条件表达式常见示例

#### 2.1 字符串的判断

`str1 = str2`			 当两个串有相同内容、长度时为真 
`str1 != str2`			当串str1和str2不等时为真 
`-n str1`　　　　　　　     当串的长度大于0时为真(串非空) 
`-z str1`　　　　　　　     当串的长度为0时为真(空串) 
`str1`					当串str1为非空时为真

#### 2.2 数字的判断

`int1 -eq int2`　　　　两数相等为真 
`int1 -ne int2`　　　　两数不等为真 
`int1 -gt int2`　　　　 int1大于int2为真 
`int1 -ge int2`　　　　int1大于等于int2为真 
`int1 -lt int2`　　　　  int1小于int2为真 
`int1 -le int2`　　　　 int1小于等于int2为真

#### 2.3 文件的判断

`-r file`　　　　　用户可读为真 
`-w file`　　　　　用户可写为真 
`-x file`　　　　　用户可执行为真 
`-f file`　　　　　文件为正规文件为真 
`-d file`　　　　　文件为目录为真 
`-c file`　　　　　文件为字符特殊文件为真 
`-b file`　　　　　文件为块特殊文件为真 
`-s file`　　　　　文件大小非0时为真 
`-t file`　　　　　当文件描述符(默认为1)指定的设备为终端时为真

#### 2.4 复杂逻辑判断

条件表达式中可能有多个条件，需要使用与或非等逻辑操作。

`-a` 　 　　　　　  与 
`-o`　　　　　　　 或 
`!`　　　　　　　　非

#### 示例一

```shell
if [ $score -ge 0 ]&&[ $score -lt 60 ];then
        echo "sorry,you are lost!"
elif [ $score -ge 60 ]&&[ $score -lt 85 ];then
        echo "just soso!"
elif [ $score -le 100 ]&&[ $score -ge 85 ];then
        echo "good job!"
else
        echo "input score is wrong , the range is [0-100]!"
fi
# 当然，上面的实例也可以用 -a 来改写：
if [ $score -ge 0 -a $score -lt 60 ];then
        echo "sorry,you are lost!"
elif [ $score -ge 60 -a $score -lt 85 ];then
        echo "just soso!"
elif [ $score -le 100 -a $score -ge 85 ];then
        echo "good job!"
else
        echo "input score is wrong , the range is [0-100]!"
fi
```

#### 示例二

```sh
CUR_DIR=$(cd `dirname $0`; pwd)
echo ${CUR_DIR}

if [ -d ${CUR_DIR}/open_source ] && [ -n "`ls ${CUR_DIR}/open_source`" ]; then
    echo "True"
fi
```

### 3. &&与||的使用

> 有时候，我们可以直接使用&&和||的组合来代替if表达式。
>
> **2.1 &&运算符**
> `command1  && command2`
> 命令之间使用 && 连接，实现逻辑与的功能。
> 只有在 && 左边的命令返回真，&& 右边的命令才会被执行。
> 只要有一个命令返回假（命令返回值 $? == 1），后面的命令就不会被执行。
> **2.2 ||运算符**
> `command1 || command2`
> 命令之间使用 || 连接，实现逻辑或的功能。
> 只有在 || 左边的命令返回假，|| 右边的命令才会被执行。
> 只要有一个命令返回真，后面的命令就不会被执行。
> 比如在ARM的uboot的mkconfig文件中的如下语句：
>
> `[ "${BOARD_NAME}" ] || BOARD_NAME="$1"`
> 这条语句的意思是如果BOARD_NAME这个变量是空的话（即前半部分条件判断返回为假），执行后边的赋值语句。