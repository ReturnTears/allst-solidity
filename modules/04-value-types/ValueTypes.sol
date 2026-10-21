// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/// @title 值类型示例
/// @notice 布尔、整数、地址、定长字节和枚举都按值复制。
contract ValueTypes {
    bool public active = true;
    uint256 public counter;
    int256 public delta = -1;
    address public owner;
    bytes32 public label = "solidity";

    enum Status {
        Pending,
        Ready,
        Done
    }

    Status public status;

    constructor() {
        owner = msg.sender;
    }

    function ranges() external pure returns (uint8 min8, uint8 max8, int8 minI8, int8 maxI8) {
        return (type(uint8).min, type(uint8).max, type(int8).min, type(int8).max);
    }

    function logic(bool left, bool right) external pure returns (bool anded, bool ored) {
        return (left && right, left || right);
    }

    function bump() external {
        counter += 1;
        if (counter > 0) status = Status.Ready;
    }

    function inspect(address account) external view returns (uint256 bal, uint256 size) {
        bal = account.balance;
        size = account.code.length;
    }

    /// @notice 把本次交易附带的 ETH 转给 to。
    function forward(address payable to) external payable returns (bool ok) {
        (ok,) = to.call{value: msg.value}("");
    }

    /// @notice 函数选择器是签名哈希的前 4 字节。
    function selector() external pure returns (bytes4) {
        return bytes4(keccak256("transfer(address,uint256)"));
    }
}
