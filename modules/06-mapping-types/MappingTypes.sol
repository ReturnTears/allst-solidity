// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/// @title 映射类型示例
/// @notice 一层映射记账，两层映射记录授权额度。
contract MappingTypes {
    mapping(address => uint256) public balances;
    mapping(address => mapping(address => uint256)) public allowance;

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function approve(address spender, uint256 amount) external {
        allowance[msg.sender][spender] = amount;
    }

    /// @notice spender 从 owner 的记账余额中划转。
    function spend(address owner, address to, uint256 amount) external {
        uint256 allowed = allowance[owner][msg.sender];
        require(allowed >= amount, "allowance");
        require(balances[owner] >= amount, "balance");

        allowance[owner][msg.sender] = allowed - amount;
        balances[owner] -= amount;
        balances[to] += amount;
    }
}
