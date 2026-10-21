// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/// @title 最小存储合约
/// @notice 保存一个整数。对应官方文档 “A Simple Smart Contract”。
contract SimpleStorage {
    uint256 private storedData;

    /// @notice 把数值写入合约状态。
    function set(uint256 value) external {
        storedData = value;
    }

    /// @notice 读取当前保存的数值。
    function get() external view returns (uint256) {
        return storedData;
    }
}
