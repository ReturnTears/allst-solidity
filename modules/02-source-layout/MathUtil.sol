// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/// @title 文件级小工具
/// @notice 演示被其他源文件显式导入的库。
library MathUtil {
    function double(uint256 x) internal pure returns (uint256) {
        return x * 2;
    }
}
