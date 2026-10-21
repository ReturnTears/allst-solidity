# 10 库

## 本章目标

把无状态的工具函数放进 `library`，并用 `using for` 把它们绑到类型上。

## 官方出处

- 文档：[Libraries](https://docs.soliditylang.org/en/latest/contracts.html#libraries) 与 [Using For](https://docs.soliditylang.org/en/latest/contracts.html#using-for)
- 源文件：[docs/contracts.rst](https://github.com/ethereum/solidity/blob/develop/docs/contracts.rst)

OpenZeppelin 把大量可复用逻辑做成库和基础合约，例如 [`Address`](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol)。本章先写一个只处理数组的本地库。

## library 和 contract 的差别

库不能有状态变量，也不能继承、不能接收 ETH。库函数是 `internal` 时，编译器把代码嵌进调用处，不必单独部署。库函数是 `public` 时，库要单独部署，调用方通过 `DELEGATECALL` 执行它：代码在库里，存储用的是调用方的存储。

因此公开库函数如果写入存储，改的是调用合约的状态，不是库自己的状态。库本身没有存储。

## using for

```solidity
using ArrayUtils for uint256[];
```

这表示 `uint256[]` 的值可以写成 `data.sum()`，编译器把该值当作库函数的第一个参数。第一个参数的数据位置要和实参一致：`storage` 数组匹配 `storage` 参数，`memory` 数组匹配 `memory` 参数。

`using` 可以写在合约内部，也可以从 0.8.13 起写在文件级。文件级 `using` 对该文件里该类型的全部用法生效。

还可以 `using ArrayUtils for uint256[] global;`，让其他文件导入后也能用这个方法语法。本章把 `using` 留在合约里，范围更直观。

## 代码导读

- [`ArrayUtils.sol`](ArrayUtils.sol) 的 `sum` 读取 `storage` 数组，`sumMemory` 读取 `memory` 数组，另外有 `contains`。两个求和函数不能同名，否则 `using for` 在存储数组上无法确定该调用哪一个。
- [`LibraryDemo.sol`](LibraryDemo.sol) 把库绑到 `uint256[]`，用 `items.sum()` 求和。传入的临时数组走 `sumMemory`。

## 练习

1. 在库里增加 `max(uint256[] storage data)`，在 `LibraryDemo` 里用 `items.max()` 调用。
2. 把 `using` 挪到文件顶层，确认合约里的调用仍然有效。

## 下一章

[11 官方示例同款练习](../11-examples/examples.md)
