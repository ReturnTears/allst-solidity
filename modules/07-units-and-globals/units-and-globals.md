# 07 单位与全局变量

## 本章目标

用 ether 和时间后缀表达数量，并在函数里正确读取 `msg`、`block` 和 `tx`。

## 官方出处

- 文档：[Units and Globally Available Variables](https://docs.soliditylang.org/en/latest/units-and-global-variables.html)
- 源文件：[docs/units-and-global-variables.rst](https://github.com/ethereum/solidity/blob/develop/docs/units-and-global-variables.rst)

## 货币单位

`1 ether == 10^18 wei`。中间还有 `gwei`（10^9 wei）。不写单位时，整数字面量的单位是 wei。

`1 ether` 这种字面量不能在代码里和 `years` 以外的任意变量做未检查的单位换算实验。金额计算直接用 wei 整数，对外显示时再换算。

## 时间单位

`1 seconds`、`1 minutes`、`1 hours`、`1 days`、`1 weeks` 都是秒数的字面量后缀。`seconds` 可以省略，因为数值本身就是秒。

没有 `months` 和 `years`：月份长度不固定，用它们会让时间条件难以推理。需要“大约 30 天”时，自己写成 `30 days`。

`block.timestamp` 是当前区块的时间戳，单位是秒。出块者可以在小范围内调整它，不能把它当作精确时钟或随机数。

## 常用全局变量

| 表达式 | 含义 |
| --- | --- |
| `msg.sender` | 当前调用的直接调用者 |
| `msg.value` | 本次调用附带的 wei。函数必须是 `payable` 才能收到非 0 金额 |
| `msg.data` | 完整的 calldata |
| `msg.sig` | calldata 的前 4 字节，即函数选择器 |
| `block.timestamp` | 区块时间 |
| `block.number` | 区块高度 |
| `block.chainid` | 链 ID |
| `tx.origin` | 交易的最初外部账户 |
| `tx.gasprice` | 交易的 gas 价格 |

权限判断用 `msg.sender`。`tx.origin` 是整笔交易的起点，中间若经过恶意合约，它仍然是用户，因此不能用来做“是不是本人在调用”的判断。第 12 章会再讲这个陷阱。

保留字不能用作变量名，例如 `block`、`msg`、`tx`、`wei`、`ether`。完整列表在官方文档的 Reserved Keywords。

## 代码导读

[`UnitsAndGlobals.sol`](UnitsAndGlobals.sol) 把价格定义成 `0.05 ether`，把持续时长定义成构造参数里的天数。`context` 返回调用者、时间和区块高度。`msg.value` 只能在 `payable` 函数里读取，所以金额放在 `buy` 的返回值里。

## 练习

1. 把 `PRICE` 改成 `50 gwei`，部署后看这个常量实际是多少 wei。
2. 增加 `function started() view returns (bool)`，当 `block.timestamp >= startTime` 时返回 `true`。

## 下一章

[08 表达式与控制流](../08-control-structures/control-structures.md)
