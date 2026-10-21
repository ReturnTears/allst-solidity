# 11 官方示例同款练习

## 本章目标

把前面的类型、映射、事件和错误放进两个完整一点的小应用：投票和竞价。

## 官方出处

- 文档：[Solidity by Example](https://docs.soliditylang.org/en/latest/solidity-by-example.html)
- 源文件：[docs/solidity-by-example.rst](https://github.com/ethereum/solidity/blob/develop/docs/solidity-by-example.rst)

官方这一章有五份合约：Voting、Blind Auction、Safe Remote Purchase、Micropayment Channel、Modular Contracts。它们篇幅长，适合在读完本章后再打开文档逐行对照。

本章的 [`Ballot.sol`](Ballot.sol) 和 [`SimpleAuction.sol`](SimpleAuction.sol) 是按同样的题目写的简化练习，方便先把状态机和“谁的钱该退回”想清楚。它们不是文档示例的拷贝。文档里的投票还包含委托，盲拍要处理两阶段出价和哈希承诺。

## 投票

`Ballot` 在构造函数里接收提案名称。主席用 `giveRight` 授权地址。每个地址只能投一次，票数记在对应提案上。

`winningProposal` 返回当前票数最高的下标。票数相同则保留更靠前的提案。没有人投票时返回 0。

链上投票要注意：映射无法枚举全部投票人，主席必须事先知道要授权谁。投票内容是公开的，交易被打包前也可能被看到。

## 竞价

`SimpleAuction` 记录最高出价。被超过的人并不立刻收到退款，金额记在 `pendingReturns` 里，由他们自己调用 `withdraw` 取回。

这样做是为了避免在 `bid` 里主动给旧出价者转账。旧出价者如果是一个会失败的合约，转账失败会把新的出价也一起回滚，拍卖就会被卡住。先记账、再由对方来取，是官方竞价示例和 Common Patterns 都在用的提款方式。

结束拍卖时，最高出价同样记到卖家的 `pendingReturns`，由卖家自己提取。

时间条件使用 `block.timestamp`。它可以被出块者小幅调整，适合“大约在这个时刻结束”，不适合当作精确截止到某一秒的金融条件。

## 练习

1. 部署 `Ballot`，构造参数使用 `["alpha","beta"]`，授权两个地址各投一票，再调用 `winningProposal`。
2. 部署 `SimpleAuction`，用两个地址轮流出价，再用较低的那个地址调用 `withdraw`，核对余额。

## 下一章

[12 安全注意点](../12-security/security.md)
