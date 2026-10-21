// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/// @title 数组工具库
/// @dev internal 函数会被调用方内联，这个库不需要单独部署。
library ArrayUtils {
    function sum(uint256[] storage data) internal view returns (uint256 total) {
        for (uint256 i = 0; i < data.length; i++) {
            total += data[i];
        }
    }

    function sumMemory(uint256[] memory data) internal pure returns (uint256 total) {
        for (uint256 i = 0; i < data.length; i++) {
            total += data[i];
        }
    }

    function contains(uint256[] storage data, uint256 value) internal view returns (bool) {
        for (uint256 i = 0; i < data.length; i++) {
            if (data[i] == value) return true;
        }
        return false;
    }
}
