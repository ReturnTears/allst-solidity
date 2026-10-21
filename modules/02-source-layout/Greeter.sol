// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {MathUtil} from "./MathUtil.sol";

/// @title 带导入和文档注释的合约
/// @author allst-solidity
/// @notice 保存一句问候语，并演示如何调用导入的库。
contract Greeter {
    string private greeting;

    /// @param text 初始问候语。
    constructor(string memory text) {
        greeting = text;
    }

    /// @return 当前问候语。
    function greet() external view returns (string memory) {
        return greeting;
    }

    /// @notice 把输入翻倍。计算发生在导入的库中。
    function scale(uint256 value) external pure returns (uint256) {
        return MathUtil.double(value);
    }
}
