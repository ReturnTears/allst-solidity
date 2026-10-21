# 03 合约结构

## 本章目标

认出合约里常见的七类成员，并在一份订单合约里把它们串起来。

## 官方出处

- 文档：[Structure of a Contract](https://docs.soliditylang.org/en/latest/structure-of-a-contract.html)
- 源文件：[docs/structure-of-a-contract.rst](https://github.com/ethereum/solidity/blob/develop/docs/structure-of-a-contract.rst)

这一章是总览。可见性、继承、库、自定义错误的细节分别在第 09、10 章和本章代码里先建立直觉。

## 合约里可以声明什么

Solidity 的合约接近面向对象语言里的类。每个合约可以包含：

| 成员 | 作用 | 在 `Purchase` 中的例子 |
| --- | --- | --- |
| 状态变量 | 存在合约存储里，交易结束后还在 | `seller`、`order` |
| 函数 | 可执行的代码单元 | `lock`、`abort` |
| 修改器 | 在函数体之前插入检查，用 `_;` 表示原函数继续执行 | `onlySeller` |
| 事件 | 写入交易日志，链下可以监听 | `StateChanged` |
| 错误 | 给回滚起一个名字，并可携带数据 | `NotSeller` |
| 结构体 | 把多个字段组成一个类型 | `Order` |
| 枚举 | 一组有限的状态名 | `State` |

还可以继承别的合约。库和接口是两种特殊合约，后面单独讲。

修改器不能按参数重载。和函数一样，修改器可以被子合约覆盖，前提是它被标成 `virtual`。

## 状态存在哪里

普通状态变量默认在 **storage**。0.8.28 起还可以用 `transient` 把变量放进瞬态存储：同一笔交易内可见，交易结束就清除。瞬态存储适合防重入锁这类“只在这一笔交易里有意义”的标记。本章示例为了兼容 0.8.24，没有使用 `transient`。

## 代码怎么读

[`Purchase.sol`](Purchase.sol) 按这个顺序工作：

1. 构造函数把部署者记为 `seller`，订单处于 `Created`。
2. 买家调用 `lock` 并附带 ETH，订单记下买家、价格，并进入 `Locked`。
3. 只有卖家能在 `Created` 阶段调用 `abort`。
4. 失败时用自定义错误回滚，而不是用一段字符串说明原因。自定义错误编码更短，gas 更低。

事件写在日志里，合约之后不能再读回这些日志。需要链上判断的数据必须放在状态变量里。

## 练习

1. 给 `Order` 增加 `uint256 createdAt`，在 `lock` 里写成 `block.timestamp`。
2. 新增状态 `Received`，并写一个只有买家能调用的 `confirm`，把状态从 `Locked` 改为 `Received`。

## 下一章

[04 值类型](../04-value-types/value-types.md)
