# 02 源文件布局

## 本章目标

读一份 `.sol` 文件时，能分清许可证、版本声明、导入和注释各自的作用。

## 官方出处

- 文档：[Layout of a Solidity Source File](https://docs.soliditylang.org/en/latest/layout-of-source-files.html)
- 源文件：[docs/layout-of-source-files.rst](https://github.com/ethereum/solidity/blob/develop/docs/layout-of-source-files.rst)
- 导入路径的进一步说明：[Import Path Resolution](https://docs.soliditylang.org/en/latest/path-resolution.html)

## 一个源文件里可以出现什么

文件顶层可以有 `pragma`、`import`、`using for`，以及合约、库、接口、结构体、枚举、函数、错误和常量。函数也可以写在合约外面，作为文件级辅助函数。

本章代码：

- [`MathUtil.sol`](MathUtil.sol) 提供一个内部库函数。
- [`Greeter.sol`](Greeter.sol) 导入它，并演示 SPDX、版本 pragma 和 NatSpec。

## SPDX 许可证标识

```solidity
// SPDX-License-Identifier: MIT
```

这行要放在文件最上方。编译器用它识别许可证。缺少时会发出警告。标识符本身不改变运行行为，机器可读的列表见 [SPDX License List](https://spdx.org/licenses/)。

## 版本 pragma

```solidity
pragma solidity ^0.8.24;
```

`^0.8.24` 表示接受 0.8.24 及以上、但不包括 0.9.0。这样可以避开不兼容的下一代编译器。

`pragma` 只对当前文件生效。被导入文件里的 pragma 不会自动套用到导入方，每个文件都要自己声明。

另一类 pragma 是 ABI 编码器选择：`pragma abicoder v2`。0.8 起默认就是 v2，普通代码不必再写。

## 导入

显式导入只把需要的符号引进来：

```solidity
import {MathUtil} from "./MathUtil.sol";
```

另外两种常见写法：

```solidity
import * as Math from "./MathUtil.sol";
import {MathUtil as M} from "./MathUtil.sol";
```

`import "./MathUtil.sol";` 会把对方的全部顶层符号倒进当前文件。官方文档不推荐这种写法，因为对方以后新增的名字会悄悄进入你的作用域。

导入路径不是本机磁盘路径的原样拷贝。编译器有自己的虚拟文件系统，标准 JSON 输入可以直接提交每个源文件的名字和内容。相对路径 `./MathUtil.sol` 在 Remix 和 `solcjs` 里都可用。

## 注释

- `//` 单行注释。
- `/* ... */` 多行注释。
- `///` 或 `/** ... */` 是 NatSpec，紧贴在函数、合约或错误声明上方，用来生成文档。

## 练习

1. 在 `MathUtil` 里加一个 `triple`，再在 `Greeter.scale` 里调用它。
2. 把 `Greeter.sol` 的 pragma 改成 `pragma solidity 0.7.6;`，看编译器如何拒绝当前语法。

## 下一章

[03 合约结构](../03-contract-structure/contract-structure.md)
