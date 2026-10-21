# Solidity

按官方文档章节整理的学习路线在 [modules/README.md](modules/README.md)。每个模块一个文件夹，内有知识点文档和对应的 `.sol` 示例。示例面向 Solidity 0.8.24+，可在 [Remix](https://remix.ethereum.org/) 中直接打开。

```text
官方学习地址：https://learnblockchain.cn/docs/solidity/layout-of-source-files.html
Solidity 是一种合约导向的编程语言，用于实现智能合约。它被设计为在以太坊区块链上运行，但也可以在其他区块链平台上使用。Solidity 通过一系列的语法和特性，允许开发者创建去中心化应用（DApps）。
Solidity 支持多种编程范式，包括面向对象、继承、库和复杂的用户定义类型等。

solidity在线编辑：https://remix.ethereum.org/

```

# Solidity 开发环境搭建

```text
借鉴：https://my.oschina.net/emacs_9242202/blog/18226852
windows环境下安装前提：
1、在 Windows 环境下开发基于 Solidity 的智能合约，需要安装一系列的前提软件和工具，以确保开发环境的正常运行。
2、安装Node和Npm
	Node.js 和 npm 是运行 Truffle 和许多其他开发工具的基础。
	官方地址： https://nodejs.org/ 下载后直接安装
	# 验证安装是否成功
	node -v
	npm -v
	设置Npm淘宝镜像：npm config set registry https://registry.npmmirror.com
	
3、安装 Git
	官方地址：https://git-scm.com/download/win
	# 验证安装是否成功
	git --version
4、安装 Python
	官方地址：https://www.python.org/downloads/windows/
	# 验证安装是否成功
	python --version

5、安装 Ganache
	Ganache 是一个本地区块链环境，可以用于开发和测试智能合约。
	官方地址：https://www.trufflesuite.com/ganache/
	
6、使用 npm 安装 Solidity 编译器
	npm install -g solc
	验证安装是否成功
	solcjs --version

```

# Solidity编码
```text
solidity文件扩展名为.sol
编译命令为：solcjs xxx.sol --bin --abi 
	--overwrite 选项允许覆盖之前编译的文件
	--optimize 选项可以优化合约的代码，减少部署到区块链上的气体消耗。
	--gas 选项可以输出合约函数的气体消耗估计。
编程成功的话会生成：二进制代码（bin）和应用程序二进制接口（ABI），.bin 文件包含了合约的二进制代码，而.abi 文件包含了合约的 ABI，它用于与合约进行交互。

🍵Solidity 源文件的布局
源文件可以包含任意数量的 contract definitions, import , pragma 和 using for，以及 struct、enum、function、error 和 常量 的定义。

SPDX 许可证标识符
// SPDX-License-Identifier: MIT

编译指令
pragma 关键字用于启用某些编译器特性或检查。
编译指令pragma 通常只对本文件有效，因此如果你希望在整个项目中启用它，必须将其添加到所有文件中。
如果你导入另一个文件，该文件的编译指令不会自动应用于导入文件。

版本编译指令
源文件可以（并且应该）用版本编译指令进行注释，以拒绝与可能引入不兼容更改的未来编译器版本的编译。
版本的形式总是: 0.x.0 或 x.0.0。
版本编译指令的用法如下：pragma solidity ^0.8.33;
包含上述行的源文件在版本低于 0.8.33 的编译器上无法编译，并且在版本从 0.9.0 开始的编译器上也无法工作（第二个条件是通过使用 ^ 添加的）。

ABI 编码器编译指令
通过使用 pragma abicoder v1 或 pragma abicoder v2，可以在 ABI 编码器和解码器的两个实现之间进行选择。

导入其他源文件
Solidity 支持导入语句，以帮助模块化代码，这些语句类似于 JavaScript 中可用的导入语句。
在全局级别，你可以使用以下形式的导入语句：
    import "filename";
    filename 部分称为 导入路径。 该语句将 “filename” 中的所有全局符号（以及在其中导入的符号）导入到当前全局作用域中（与 ES6 不同，但对 Solidity 向后兼容）。 
    不推荐使用这种形式，因为它不可预测地污染命名空间。 如果你在 “filename” 中添加新的顶级项，它们会自动出现在所有以这种方式从 “filename” 导入的文件中。
    最好显式导入特定符号。
    以下示例创建了一个新的全局符号 symbolName，其成员是来自 "filename" 的所有全局符号：
        import * as symbolName from "filename";
        这使得所有全局符号都可以以 symbolName.symbol 的格式使用。
        import "filename" as symbolName; // 等价于上述
    如果存在命名冲突，可以在导入时重命名符号。例如，下面的代码创建了新的全局符号 alias 和 symbol2，分别引用 "filename" 中的 symbol1 和 symbol2。
    import {symbol1 as alias, symbol2} from "filename";

导入路径
为了能够在所有平台上支持可重复构建，Solidity 编译器必须抽象出源文件存储的文件系统的细节。 因此，导入路径并不直接指向主机文件系统中的文件。 
相反，编译器维护一个内部数据库（简称 虚拟文件系统 或 VFS），其中每个源单元被分配一个唯一的 源单元名称，这是一个不透明且无结构的标识符。 
在导入语句中指定的导入路径被转换为源单元名称，并用于在该数据库中查找相应的源单元。
使用 标准 JSON API，可以直接提供所有源文件的名称和内容作为编译器输入的一部分。

注释
单行注释（//）和多行注释（/*...*/）都是可以的。
// 这是一个单行注释。
/*
这是一个
多行注释。
*/
还有另一种类型的注释，称为 NatSpec 注释，它们使用三重斜杠（///）或双星号块（/** ... */）编写，应该直接放在函数声明或语句的上方。


🍎合约的结构
Solidity 中的合约类似于面向对象语言中的类。 
每个合约可以包含 状态变量、函数、函数修改器、事件、错误、结构体类型 和 枚举类型 的声明。 此外，合约可以从其他合约继承。
还有一些特殊类型的合约，称为 libraries 和 interfaces。

🍊状态变量
状态变量是其值永久存储在合约存储中，或者临时存储在每个交易结束时会被清除的瞬态存储中的变量。 
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.0 <0.9.0;

contract SimpleStorage {
    uint storedData; // 状态变量
    // ...
}
有关有效状态变量类型的信息，以及 可见性和 getter 函数 以获取可选的可见性选择。

🍊函数
函数是可执行的代码单元。函数通常在合约内部定义，但也可以在合约外部定义。
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.1 <0.9.0;

contract SimpleAuction {
    function bid() public payable { // 函数
        // ...
    }
}

// 在合约外部定义的辅助函数
function helper(uint x) pure returns (uint) {
    return x * 2;
}
函数调用 可以在内部或外部发生，并且对其他合约具有不同级别的 visibility。
Functions 接受 parameters and return variables 以在它们之间传递参数和数值。

🍊函数修改器
函数 修改器modifier 可以以声明的方式修改函数的语义。
重载，即使用不同参数的相同修改器名称，是不可能的。
与函数一样，修改器可以被 overridden。
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.22 <0.9.0;

contract Purchase {
    address public seller;

    modifier onlySeller() { // 修改器
        require(
            msg.sender == seller,
            "只有卖家可以调用此函数。"
        );
        _;
    }

    function abort() public view onlySeller { // 修改器使用
        // ...
    }
}

🍊事件
事件是能方便地调用以太坊虚拟机日志功能的接口。
// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.22;

event HighestBidIncreased(address bidder, uint amount); // 事件

contract SimpleAuction {
    function bid() public payable {
        // ...
        emit HighestBidIncreased(msg.sender, msg.value); // 触发事件
    }
}

🍊错误
错误允许你为失败情况定义描述性名称和数据。 错误可以在 revert statements 中使用。 
与字符串描述相比，错误的成本更低，并且允许你编码额外的数据。还可以使用 NatSpec 来描述错误给用户。
// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

/// 转账资金不足。请求的 `requested`，
/// 但只有 `available` 可用。
error NotEnoughFunds(uint requested, uint available);

contract Token {
    mapping(address => uint) balances;
    function transfer(address to, uint amount) public {
        uint balance = balances[msg.sender];
        if (balance < amount)
            revert NotEnoughFunds(amount, balance);
        balances[msg.sender] -= amount;
        balances[to] += amount;
        // ...
    }
}

🍊结构体类型
结构是自定义定义的类型，可以将多个变量分组
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.0 <0.9.0;

contract Ballot {
    struct Voter { // 结构
        uint weight;
        bool voted;
        address delegate;
        uint vote;
    }
}

🍊枚举类型
枚举可用于创建具有有限“常量值”集合的自定义类型
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.0 <0.9.0;

contract Purchase {
    enum State { Created, Locked, Inactive } // 枚举
}


🍎类型
Solidity 是一种静态类型语言，这意味着每个变量（状态变量和局部变量）的类型都需要被指定。 Solidity 提供了几种基本类型，可以组合形成复杂类型。
类型可以在包含运算符的表达式中相互作用。
“undefined”或“null”值的概念在 Solidity 中不存在，但新声明的变量总是具有依赖于其类型的 默认值。 
为了处理任何意外值，应该使用 revert function 来回滚整个交易，或者返回一个包含第二个 bool 值表示成功的元组。

🍊值类型
以下被称为值类型，因为它们的变量总是按值传递，即在用作函数参数或赋值时总是被复制。
与 引用类型 不同，值类型声明不指定数据位置，因为它们足够小，可以存储在栈上。 唯一的例外是 状态变量。 
这些变量默认位于存储中，但也可以标记为 瞬态、常量或不可变。

🍒布尔类型
bool：可能的值是常量 true 和 false。
运算符：! （逻辑非）、&& （逻辑与，“和”）、|| （逻辑或，“或”）、== （相等）、!= （不相等）、
运算符 || 和 && 遵循常见的短路规则。 这意味着在表达式 f(x) || g(y) 中，如果 f(x) 计算为 true，则 g(y) 将不会被计算，即使它可能有副作用。

🍒整型
int / uint：各种大小的有符号和无符号整数。 关键字 uint8 到 uint256 以 8 为步长（无符号从 8 位到 256 位）和 int8 到 int256。 
uint 和 int 分别是 uint256 和 int256 的别名。
Solidity 中的整数限制在某个范围内。例如，对于 uint32，范围是 0 到 2**32 - 1。
运算符：
    比较：<=、<、==、!=、>=、>``（计算为 ``bool）
    位运算符：&、|、``^``（按位异或）、``~``（按位取反）
    移位运算符：<<``（左移）、>>``（右移）
    算术运算符：+、-、一元 -``（仅适用于有符号整数）、``*、/、``%``（取模）、``**``（指数）
对于整数类型 X，可以使用 type(X).min 和 type(X).max 来访问该类型可表示的最小值和最大值。   



```
