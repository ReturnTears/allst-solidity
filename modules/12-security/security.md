# 12 安全注意点

## 本章目标

知道官方安全章节里最常见的几类事故，并在提款合约里先改账再转账。

## 官方出处

- 文档：[Security Considerations](https://docs.soliditylang.org/en/latest/security-considerations.html)
- 源文件：[docs/security-considerations.rst](https://github.com/ethereum/solidity/blob/develop/docs/security-considerations.rst)
- 已知问题列表：[List of Known Bugs](https://docs.soliditylang.org/en/latest/bugs.html)

链上代码部署后很难修改。调用者可以构造任何输入，也可以在你转账时执行他们自己的合约。上线前需要代码评审、测试和审计。编译器告警要处理掉。

## 需要记住的几类问题

**重入。** 合约在转出 ETH 时，对方的 `receive` 或 `fallback` 会立刻执行，并可以再次调用你的提款函数。如果余额还没清掉，同一次提取就会发生多次。后果是合约里的 ETH 被超出记账额度转走。

防御是检查-生效-交互：先检查条件，再更新本合约状态，最后才做外部调用。[`Vault.sol`](Vault.sol) 先把 `balanceOf` 写成 0，再 `call`。修改器 `nonReentrant` 在调用期间把锁设上，返回后再打开。OpenZeppelin 的 [`ReentrancyGuard`](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/ReentrancyGuard.sol) 是同一思路的通用实现。

**用 `tx.origin` 做权限。** 它是整笔交易的起点。用户若调用了一个中间合约，中间合约再调用你，`tx.origin` 仍是用户，`msg.sender` 才是中间合约。权限判断要用 `msg.sender`。

**在循环里主动付款。** 某一个接收方回滚，整次分配都会失败，后面的人永远拿不到。把金额记到映射里，让每个人自己提取。第 11 章的竞价和第 13 章的钱包都是这样做的。

**溢出。** 0.8 之前的整数会静默环绕。0.8 起默认回滚。不要为了省 gas 把未证明安全的运算放进 `unchecked`。

**可见性。** 该限制调用者的函数不要写成 `public` 又不加检查。`private` 也不能隐藏数据，存储内容谁都可以读。

**把合约当私钥库。** 随机数不能取 `block.timestamp` 或 `block.prevrandao` 的裸值来决定资金归属，出块者可以影响这些值。需要不可预测的随机数时，使用链下提交或专门的随机数协议，并在集成前阅读该协议的威胁模型。

**`selfdestruct`。** 坎昆升级之后，它不再保证删掉合约代码。不要用它实现“销毁后不可调用”这类业务前提。

编译器、语言版本和已知 bug 列表会更新。生产合约固定编译器版本，并在升级编译器时阅读 [0.8.0 的破坏性变更](https://docs.soliditylang.org/en/latest/080-breaking-changes.html) 以及之后版本的发行说明。

## 代码导读

[`Vault.sol`](Vault.sol) 只实现存款和提款：

1. `deposit` 把 `msg.value` 加进调用者的余额。
2. `withdraw` 进入 `nonReentrant`。
3. 先把余额置 0，再把 ETH 发给调用者。
4. 转账失败则整次调用回滚，余额修改也会撤销。

## 练习

1. 在 Remix 里用两个地址分别存款、提款，核对合约的 ETH 余额和 `balanceOf`。
2. 读官方文档 Pitfalls 一节，把其中和“外部调用”相关的条目用自己的话写在笔记里。

## 下一章

[13 常用模式](../13-common-patterns/common-patterns.md)
