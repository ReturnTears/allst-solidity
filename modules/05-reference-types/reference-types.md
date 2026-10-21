# 05 引用类型

## 本章目标

会为数组、结构和动态字节选择正确的数据位置，并知道赋值时什么时候是复制、什么时候是引用。

## 官方出处

- 文档：[Reference Types](https://docs.soliditylang.org/en/latest/types.html#reference-types)
- 源文件：[docs/types.rst](https://github.com/ethereum/solidity/blob/develop/docs/types.rst) 中 Reference Types 一节

## 三种数据位置

引用类型必须标明数据位置：

| 位置 | 生命周期 | 赋值含义 |
| --- | --- | --- |
| `storage` | 跟合约状态一样持久 | 局部的 storage 变量是引用，改它就是改链上数据 |
| `memory` | 一次函数调用期间 | 赋值会复制一份 |
| `calldata` | 只读的外部调用参数 | 不能修改，外部函数的动态参数优先用它，比 `memory` 省 gas |

从 `storage` 赋到 `memory` 会复制。两个 `storage` 局部变量可以指向同一块状态。从 `memory` 写回 `storage` 也会复制。

## 常见引用类型

- **动态数组** `T[]`：`push`、`pop`、`length`。长度存在存储里，元素另算。
- **定长数组** `T[n]`：长度是类型的一部分。
- **结构体**：把多个字段绑在一起。可以放在数组或映射里。
- **`bytes`**：动态字节数组，可以按下标改。
- **`string`**：动态 UTF-8 字节。不能按下标读取，一般整段读写。
- **映射**：下一章单独讲。它只能放在 `storage`。

局部的 `memory` 数组要用 `new uint256[](length)` 创建。不能对 `memory` 数组 `push`。

## 代码导读

[`ReferenceTypes.sol`](ReferenceTypes.sol)：

- `addUser` 的参数是 `calldata`，推进状态数组时再复制进 `storage`。
- `updateStorage` 用 `User storage` 直接改链上那一项。
- `copyToMemory` 先复制到 `memory`，再返回。修改这个内存副本不会影响链上数组。
- `join` 演示 `memory` 数组的长度在创建时确定。

## 练习

1. 给 `User` 加上 `bytes32 tag`。写一个函数，用 `storage` 引用只更新 tag。
2. 写 `removeLast`，调用 `users.pop()`。想一想：这是把最后一项清掉，不是按索引删除中间项。

## 下一章

[06 映射](../06-mapping-types/mapping-types.md)
