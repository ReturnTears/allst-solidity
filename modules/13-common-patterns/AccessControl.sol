// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

error NotOwner(address caller);
error NotOperator(address caller);

/// @title 所有者与操作员
contract AccessControl {
    address public owner;
    mapping(address => bool) public operators;

    event OwnerChanged(address indexed previousOwner, address indexed newOwner);
    event OperatorSet(address indexed account, bool allowed);

    modifier onlyOwner() {
        if (msg.sender != owner) revert NotOwner(msg.sender);
        _;
    }

    modifier onlyOperator() {
        if (!operators[msg.sender]) revert NotOperator(msg.sender);
        _;
    }

    constructor() {
        owner = msg.sender;
        operators[msg.sender] = true;
        emit OwnerChanged(address(0), msg.sender);
    }

    function transferOwnership(address newOwner) external onlyOwner {
        require(newOwner != address(0), "zero address");
        address previous = owner;
        owner = newOwner;
        emit OwnerChanged(previous, newOwner);
    }

    function setOperator(address account, bool allowed) external onlyOwner {
        require(account != address(0), "zero address");
        operators[account] = allowed;
        emit OperatorSet(account, allowed);
    }

    /// @notice 业务函数的占位示例，只有操作员能调用。
    function operate() external view onlyOperator returns (address) {
        return msg.sender;
    }
}
