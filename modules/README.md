# Solidity 学习路线

章节顺序对齐 [Solidity 官方文档](https://docs.soliditylang.org/en/latest/)（Language Description 与 Basics）。文档源文件在 [ethereum/solidity 的 docs 目录](https://github.com/ethereum/solidity/tree/develop/docs)。示例是根据这些章节写的教学代码，方便在 Remix 或 `solcjs` 里编译，不是把官方仓库里的合约原样复制过来。

生产级权限、重入防护等实现，建议对照 [OpenZeppelin Contracts](https://github.com/OpenZeppelin/openzeppelin-contracts) 阅读，本仓库里的版本只保留教学所需的最小结构。

当前语言版本线是 0.8.x。部署时使用已发布的最新 0.8 编译器；下面的示例统一写成 `pragma solidity ^0.8.24;`。

| 顺序 | 模块 | 对应官方章节 | 你会写出的代码 |
| --- | --- | --- | --- |
| 01 | [智能合约入门](01-smart-contracts/smart-contracts.md) | Introduction to Smart Contracts | 存储一个整数并读出来 |
| 02 | [源文件布局](02-source-layout/source-layout.md) | Layout of a Solidity Source File | 许可证、pragma、import、NatSpec |
| 03 | [合约结构](03-contract-structure/contract-structure.md) | Structure of a Contract | 状态、函数、修改器、事件、错误、结构体、枚举 |
| 04 | [值类型](04-value-types/value-types.md) | Types / Value Types | 布尔、整数、地址、定长字节、枚举 |
| 05 | [引用类型](05-reference-types/reference-types.md) | Types / Reference Types | `storage`、`memory`、`calldata`、数组、字符串 |
| 06 | [映射](06-mapping-types/mapping-types.md) | Types / Mapping Types | 余额表与嵌套授权表 |
| 07 | [单位与全局变量](07-units-and-globals/units-and-globals.md) | Units and Globally Available Variables | ether、时间、`msg`、`block` |
| 08 | [表达式与控制流](08-control-structures/control-structures.md) | Expressions and Control Structures | 分支循环、`require`、`unchecked`、`new`、`try/catch` |
| 09 | [合约进阶](09-contracts/contracts.md) | Contracts | 可见性、常量、继承、接口、抽象合约 |
| 10 | [库](10-libraries/libraries.md) | Libraries / Using For | `library` 与 `using for` |
| 11 | [官方示例同款练习](11-examples/examples.md) | Solidity by Example | 投票与竞价 |
| 12 | [安全注意点](12-security/security.md) | Security Considerations | 先改状态再转账，并加防重入锁 |
| 13 | [常用模式](13-common-patterns/common-patterns.md) | Common Patterns | 提款、权限、状态机 |
| 14 | [继续往下](14-advanced/advanced.md) | ABI、Assembly、NatSpec、Style Guide | `abi.encode` 与一段 Yul 加法 |

在模块目录下编译单个文件：

```text
solcjs --bin --abi --overwrite 路径/合约.sol
```

带 `import` 的文件要在项目根目录编译，这样相对路径才能解析：

```text
solcjs --bin --abi --overwrite modules/02-source-layout/Greeter.sol
```
