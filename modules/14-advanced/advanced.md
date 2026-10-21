# 14 继续往下

## 本章目标

会做一次 ABI 编解码，看懂一段最小的内联汇编，并知道官方文档后面还剩哪些章节。

## 官方出处

- [ABI 编码函数](https://docs.soliditylang.org/en/latest/cheatsheet.html#abi-encoding-and-decoding-functions) 与 [Contract ABI Specification](https://docs.soliditylang.org/en/latest/abi-spec.html)
- 源文件：[docs/abi-spec.rst](https://github.com/ethereum/solidity/blob/develop/docs/abi-spec.rst)、[docs/cheatsheet.rst](https://github.com/ethereum/solidity/blob/develop/docs/cheatsheet.rst)
- [Inline Assembly](https://docs.soliditylang.org/en/latest/assembly.html) 与中间语言 [Yul](https://docs.soliditylang.org/en/latest/yul.html)
- [NatSpec](https://docs.soliditylang.org/en/latest/natspec-format.html)
- [Style Guide](https://docs.soliditylang.org/en/latest/style-guide.html)

## ABI

合约之间、以及链下程序和合约之间，按 ABI 规则把函数参数编码成字节。函数选择器是 `bytes4(keccak256("函数名(参数类型)"))`，第 04 章已经算过一次。

常用函数：

| 函数 | 作用 |
| --- | --- |
| `abi.encode(...)` | 按 ABI 规则编码，每个值至少占 32 字节 |
| `abi.encodePacked(...)` | 紧凑拼接，不同参数可能产生相同字节，不要单独拿它做签名或承诺 |
| `abi.decode(data, (类型))` | 把 `abi.encode` 的结果解回来 |
| `abi.encodeWithSignature` | 在参数编码前加上 4 字节选择器，适合低级 `call` |

[`AbiAndAssembly.sol`](AbiAndAssembly.sol) 的 `pack` 和 `unpack` 对同一个 `uint256` 做往返。`encodePacked` 容易冲突，官方文档建议签名时使用 `abi.encode` 或链上的结构化哈希方案，而不是把动态类型直接 `encodePacked`。

## 内联汇编

`assembly { ... }` 里写的是 Yul。它能直接操作 EVM 指令，也能绕过 Solidity 的部分检查。官方文档把汇编放在语言说明的后部，并单列了“不要做的事”：不要随意覆盖 Solidity 使用的内存，不要假设局部变量在内存中的布局永远不变。

本章只保留一条与 Solidity 加法对应的指令：

```solidity
assembly {
    result := add(a, b)
}
```

这段代码不会做 0.8 的溢出检查。输入大到绕过 `2^256 - 1` 时，结果会截断。业务运算继续用 Solidity 表达式。

## 文档后面还有什么

读完本路线后，官方目录里还值得按需要打开的部分：

- **Compiler / Internals**：字节码、存储布局、优化器、元数据。升级代理或手写存储槽之前要读存储布局。
- **NatSpec**：`@title`、`@notice`、`@param`、`@return`、`@dev`。本仓库示例已经在使用其中一部分。
- **Style Guide**：官方建议的空行、命名和声明顺序。
- **SMTChecker**：用形式化方法辅助找算术和断言问题。
- **Language Grammar**：需要写解析器或编辑器插件时再看。

发行说明和破坏性变更在文档的 Advisory content。编译器源码、测试和语言设计讨论在 [ethereum/solidity](https://github.com/ethereum/solidity)。

## 练习

1. 调用 `pack(1)` 再 `unpack`，确认结果仍是 1。
2. 打开 [Style Guide](https://docs.soliditylang.org/en/latest/style-guide.html)，把 `AbiAndAssembly` 的状态变量和函数顺序对照一遍。
