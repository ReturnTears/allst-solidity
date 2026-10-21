# 06 映射

## 本章目标

用映射保存“键到值”的链上数据，并知道它不能遍历、也不能作为内存变量。

## 官方出处

- 文档：[Mapping Types](https://docs.soliditylang.org/en/latest/types.html#mapping-types)
- 源文件：[docs/types.rst](https://github.com/ethereum/solidity/blob/develop/docs/types.rst) 中 Mapping Types 一节

## 行为

```solidity
mapping(address => uint256) balances;
```

- 键不是存在数组里，而是参与存储槽的计算。任意键都有默认值，`uint256` 的默认值是 0。因此“键不存在”和“值刚好是 0”看起来一样。需要区分时，另存一个 `bool` 或单独的计数。
- 映射只能放在 `storage`。函数参数可以写成 `mapping(...) storage`，用来把合约里的映射传给内部函数或库。
- 映射没有长度，也不能 `for` 循环所有键。如果业务要列出全部地址，需要另外维护一个数组，并接受数组和映射可能不一致的维护成本。
- 可以嵌套：`mapping(address => mapping(address => uint256))`。公开映射会得到一个需要传入全部键的读取函数。

映射作为状态变量时，如果标成 `public`，编译器生成的 getter 只接受键、返回值。映射的值如果是结构体，getter 会跳过其中的映射和动态数组字段。

## 代码导读

[`MappingTypes.sol`](MappingTypes.sol) 是一份最小记账：

- `balances` 记录每个地址存入的 wei。
- `allowance` 是两层映射，表示“所有者授权给花费者多少额度”。
- `spend` 由被授权的地址调用，同时减少额度和所有者余额。

这里的余额是合约内部记账，和地址真正的 ETH 余额不是同一个数。`deposit` 把两者一起增加：ETH 进入合约，`balances[msg.sender]` 加上同样的数额。

## 练习

1. 增加 `withdraw(uint256 amount)`，减少自己的记账余额，再用 `call` 把 ETH 退回。先改余额，再转账。
2. 增加 `mapping(address => bool) exists` 和一个地址数组，在第一次存款时把地址推进数组。写一个函数返回已记录的地址数量。

## 下一章

[07 单位与全局变量](../07-units-and-globals/units-and-globals.md)
