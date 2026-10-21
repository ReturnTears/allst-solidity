# 13 常用模式

## 本章目标

会写官方 Common Patterns 里的三种结构：提款、限制访问、状态机。

## 官方出处

- 文档：[Common Patterns](https://docs.soliditylang.org/en/latest/common-patterns.html)
- 源文件：[docs/common-patterns.rst](https://github.com/ethereum/solidity/blob/develop/docs/common-patterns.rst)

OpenZeppelin 把这些模式做成了可继承合约。权限可对照 [`Ownable`](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol)。本章三种合约是便于阅读的独立教学版。

## 提款

合约收到 ETH 后先记账。用户调用 `withdraw` 取走自己的余额。调用前把余额清零，这样对方在收款回调里再次进入时，账上已经是 0。

[`WithdrawalWallet.sol`](WithdrawalWallet.sol) 就是这个模式。它和第 12 章的金库类似，这里不再加锁，用来单独看“记账”这件事。生产代码里两道防护通常一起用。

## 限制访问

把“谁可以调用”收成修改器，而不是在每个函数里复制一遍判断。

[`AccessControl.sol`](AccessControl.sol) 有所有者和操作员两级：

- 构造函数把部署者设为 `owner`。
- `onlyOwner` 才能更换所有者和设置操作员。
- `onlyOperator` 才能调用业务函数 `operate`。

所有权转移要小心把地址写成 0。这里直接拒绝零地址。更完整的实现会把转移拆成“提名”和“接受”两步，避免转到一个谁都控制不了的地址。

## 状态机

一个合约如果有明确阶段，就把阶段放进枚举，并用修改器限制每个函数只能在对应阶段调用。

[`StateMachine.sol`](StateMachine.sol) 的阶段是 `Created -> Active -> Finished`。`start` 只在创建后可调用，`finish` 只在激活后可调用。阶段只能向前走。

第 03 章的订单和第 11 章的拍卖已经在用这个想法。本章把它收成可以单独模仿的骨架。

## 练习

1. 给 `AccessControl` 增加 `renounceOperator`，让操作员取消自己的权限。
2. 给 `StateMachine` 增加 `cancel`，只允许在 `Active` 阶段把阶段设为 `Finished`，并发出带原因的事件。

## 下一章

[14 继续往下](../14-advanced/advanced.md)
