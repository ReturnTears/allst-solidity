# 08 表达式与控制流

## 本章目标

会写条件、循环和三类失败语句，并知道 0.8 的溢出检查什么时候可以关掉。

## 官方出处

- 文档：[Expressions and Control Structures](https://docs.soliditylang.org/en/latest/control-structures.html)
- 源文件：[docs/control-structures.rst](https://github.com/ethereum/solidity/blob/develop/docs/control-structures.rst)

## 控制结构

Solidity 有 `if` / `else`、`while`、`do` / `while`、`for`、`break`、`continue` 和 `return`。没有 `switch`。

循环次数受 gas 限制。对链上数组做无上限循环，数组变长后可能永远无法成功执行。需要遍历时，给长度设上限，或把工作拆到多次调用里。

表达式的求值顺序在官方文档里有单独说明：不要依赖同一条语句里多个副作用的先后。把有副作用的调用拆成独立语句。

## 失败时怎么停

| 语句 | 用途 |
| --- | --- |
| `require(条件, "说明")` | 检查输入或外部条件。0.8 起也可以 `require(条件)`，再用自定义错误表达原因 |
| `revert CustomError(...)` | 回滚并返回一个命名错误。比字符串更省 gas |
| `assert(条件)` | 检查内部不变量。失败表示程序有 bug。Panic 错误码和普通 `require` 不同 |
| `try` / `catch` | 接住对外部合约调用的失败，本合约可以选择继续 |

这三种回滚都会撤销本次调用里的状态修改。`assert` 失败通常表示“这不该发生”，不要拿它检查用户输入。

## 溢出检查

0.8 起，`+ - *` 以及自增在溢出时回滚。把一段运算放进 `unchecked { }` 会恢复截断环绕，并省掉检查的 gas。只在不变量已经保证不会溢出时使用，例如“先检查过余额再相减”，或循环变量明显不会绕回。

除以 0、对 0 取模，仍然会回滚。

## 创建合约与外部调用

`new Echo()` 在当前交易里部署一份新合约，构造函数立刻执行。

对外部合约的调用如果失败，默认把失败继续抛出。用 `try` / `catch` 可以只处理这一次调用的失败。`catch Error(string memory reason)` 接 `require` 风格的字符串错误，`catch Panic(uint errorCode)` 接断言和溢出，`catch (bytes memory raw)` 接其余情况。

## 代码导读

[`ControlFlow.sol`](ControlFlow.sol) 包含：

- `sumTo`：有上限的 `for` 循环。
- `onlyPositive`：`require` 检查参数。
- `mustBeEven`：自定义错误。
- `checkedAdd` / `uncheckedAdd`：同一加法的两种溢出语义。
- `createEcho`：用 `new` 部署 [`Echo`](ControlFlow.sol) 合约。
- `tryDouble`：外部调用失败时返回 `success = false`，而不是让整笔交易回滚。

## 练习

1. 把 `sumTo` 的上限从 100 改成 10，用 11 调用，确认自定义路径会回滚。
2. 让 `Echo.echo` 在 `x == 0` 时 `revert`，再调用 `tryDouble`，看返回值里的 `success`。

## 下一章

[09 合约进阶](../09-contracts/contracts.md)
