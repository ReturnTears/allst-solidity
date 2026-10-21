# 04 值类型

## 本章目标

分清哪些类型按值复制，并会使用整数范围、地址和定长字节。

## 官方出处

- 文档：[Types](https://docs.soliditylang.org/en/latest/types.html)
- 源文件：[docs/types.rst](https://github.com/ethereum/solidity/blob/develop/docs/types.rst)

## 值类型和引用类型

值类型在赋值和传参时总是复制一份。它们放在栈上，声明时不用写数据位置。状态变量是例外：默认在 storage，也可以标成 `constant`、`immutable` 或 `transient`。

Solidity 没有 `null` 或 `undefined`。新变量会得到该类型的默认值：布尔是 `false`，整数是 `0`，地址是 `address(0)`。

引用类型（数组、结构体、映射）在下一章开始讲。

## 本章涉及的值类型

| 类型 | 要点 |
| --- | --- |
| `bool` | `true` / `false`。逻辑与、逻辑或都会短路 |
| `uint8` … `uint256` | 无符号整数，步长 8。`uint` 就是 `uint256` |
| `int8` … `int256` | 有符号整数。`int` 就是 `int256` |
| `address` | 20 字节账户地址。`.balance`、`.code` 可读 |
| `address payable` | 可以接收 ETH 的地址。需要显式转换 |
| `bytes1` … `bytes32` | 定长字节数组，按值复制 |
| `enum` | 一组命名常量，底层是从 0 开始的整数 |
| 函数类型 | 把函数当成值传递。内部函数和外部函数是两类 |

整数运算在 0.8 里默认检查溢出，溢出会回滚。想要截断环绕时，把表达式放进 `unchecked { }`，第 08 章有例子。

`type(uint256).min` 和 `type(uint256).max` 给出该整数类型的边界。

地址之间的转换：`payable` 转到普通 `address` 可以隐式进行；反过来必须写 `payable(addr)`。

`bytes32` 是定长值类型。动态的 `bytes` 和 `string` 是引用类型，不要和 `bytes1`…`bytes32` 混在一起。

## 代码导读

[`ValueTypes.sol`](ValueTypes.sol) 把这些类型放进状态或纯函数里：

- `ranges` 读取 `uint8` 和 `int8` 的最小、最大值。
- `logic` 演示布尔短路运算符的结果。
- `inspect` 读取任意地址的余额和代码长度。
- `forward` 把本次调用附带的 ETH 转到一个 `address payable`。
- `selector` 取函数选择器的前 4 字节，这是 ABI 调用的入口标识。

## 练习

1. 增加 `int256` 状态变量，写一个函数把它加上传入的增量。传入一个会溢出的值，观察交易回滚。
2. 定义枚举 `Level { Low, Medium, High }`，写函数只接受 `High` 时返回 `true`。

## 下一章

[05 引用类型](../05-reference-types/reference-types.md)
