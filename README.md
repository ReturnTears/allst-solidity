# Solidity

```text
官方学习地址：https://learnblockchain.cn/docs/solidity/layout-of-source-files.html
Solidity 是一种合约导向的编程语言，用于实现智能合约。它被设计为在以太坊区块链上运行，但也可以在其他区块链平台上使用。Solidity 通过一系列的语法和特性，允许开发者创建去中心化应用（DApps）。
Solidity 支持多种编程范式，包括面向对象、继承、库和复杂的用户定义类型等。

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


```
