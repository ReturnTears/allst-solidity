# 01 智能合约入门

## 本章目标

知道智能合约在以太坊里扮演什么角色，并能读懂、改动一份最小合约。

## 官方出处

- 文档：[Introduction to Smart Contracts](https://docs.soliditylang.org/en/latest/introduction-to-smart-contracts.html)
- 源文件：[docs/introduction-to-smart-contracts.rst](https://github.com/ethereum/solidity/blob/develop/docs/introduction-to-smart-contracts.rst)

## 三件事

**智能合约是账户里的程序。** 以太坊账户分两种：外部账户由私钥控制，合约账户由代码控制。合约代码部署后存在链上，任何人都可以按它公开的函数发起交易。

**区块链记录的是状态变化。** 一次交易被打包进区块后，所有节点按同一套规则执行，得到同一份状态。合约里的状态变量就是这份状态的一部分，交易结束后仍然保留。

**代码跑在 EVM 上。** Solidity 先被编译成 EVM 字节码。每次执行都要付 gas。gas 用尽或执行遇到回滚，本次交易对状态的修改全部取消，但已经消耗的 gas 不会退回。

官方文档把入门拆成三节：一份简单合约、区块链基础、以太坊虚拟机。本章代码对应第一节。

## 最小合约在做什么

[`SimpleStorage.sol`](SimpleStorage.sol) 只有一个状态变量和两个函数：

- `set` 写入链上状态，调用者要发交易并付 gas。
- `get` 只读取状态，标记为 `view`，不修改链上数据。

`///` 开头的注释是 NatSpec，编译器可以把它放进合约元数据。完整标签在第 14 章再展开。

## 和交易相关的几个词

| 词 | 含义 |
| --- | --- |
| 部署 | 把字节码放进一个新的合约账户，构造函数只在这时执行一次 |
| 调用 | 对已部署合约发交易，执行其中某个函数 |
| 回滚 | 本次交易中的状态修改全部撤销 |
| gas | 按执行的操作计费，用来限制计算量 |

## 练习

1. 在 Remix 中部署 `SimpleStorage`，调用 `set(42)`，再调用 `get`。
2. 把 `storedData` 改成 `public`，观察编译器自动生成的同名读取函数，然后删掉手写的 `get`，确认外部仍然能读到数值。

## 下一章

[02 源文件布局](../02-source-layout/source-layout.md)
