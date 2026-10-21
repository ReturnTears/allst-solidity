# 09 合约进阶

## 本章目标

选对函数可见性和状态可变性，并用继承、抽象合约和接口把行为拆开。

## 官方出处

- 文档：[Contracts](https://docs.soliditylang.org/en/latest/contracts.html)
- 源文件：[docs/contracts.rst](https://github.com/ethereum/solidity/blob/develop/docs/contracts.rst)

## 可见性

| 说明符 | 谁能调用 |
| --- | --- |
| `external` | 其他账户和其他合约。本合约内部要用 `this.f()` |
| `public` | 外部和内部都可以。公开状态变量会自动得到一个 getter |
| `internal` | 本合约和子合约 |
| `private` | 仅本合约。子合约也不能调用 |

`private` 只约束 Solidity 调用，链上状态仍然公开。不要把秘密放进状态变量。

## 状态可变性

- `view`：只读状态。
- `pure`：不读也不写状态。
- `payable`：可以接收 ETH。

构造函数在部署时执行一次。`receive() external payable` 在调用没有数据时收款。`fallback()` 在没有匹配函数时执行。两者可以同时存在：空 calldata 走 `receive`，其余走 `fallback`。

## 常量

- `constant`：编译期确定，不占存储槽。
- `immutable`：构造时写一次，之后不能改。读取成本和常量接近。

## 继承

子合约用 `is`。要允许覆盖的函数标 `virtual`，覆盖时标 `override`。多重继承的线性化使用 C3，和 Python 一样；需要调用上一层实现时用 `super`。

抽象合约用 `abstract`，可以有未实现的函数，不能单独部署。

接口的函数默认是 `external`，不能有状态变量和构造函数。接口用来约定“对方至少有这些函数”，调用前把它的地址转成接口类型。

公开状态变量的 getter 可以满足接口里同名、同返回值的 `external view` 函数。

## 代码导读

- [`VisibilityDemo.sol`](VisibilityDemo.sol)：四种可见性、`constant`、`immutable`、`receive` 和 `fallback`。
- [`InheritanceDemo.sol`](InheritanceDemo.sol)：`ICounter`、抽象的 `BaseCounter`，以及按步长覆盖 `increment` 的 `StepCounter`。

官方文档在这一章还写了瞬态存储和自定义存储布局。瞬态存储从 0.8.28 开始，关键字是 `transient`。自定义存储布局用 `layout at`，适合代理合约的存储间隙。需要时直接查阅上面的 Contracts 文档，本章示例保持在 0.8.24 可编译的范围内。

## 练习

1. 让 `VisibilityDemo` 的子合约调用 `_bump`，确认 `private` 的 `_double` 不能在子合约里调用。
2. 再写一个 `DoubleCounter`，继承 `BaseCounter`，每次 `increment` 加 2。

## 下一章

[10 库](../10-libraries/libraries.md)
