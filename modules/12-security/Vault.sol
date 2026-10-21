// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/// @title 先改账再转账的金库
/// @notice 用检查-生效-交互和一把重入锁保护提款。
contract Vault {
    mapping(address => uint256) public balanceOf;
    uint256 private locked = 1;

    modifier nonReentrant() {
        require(locked == 1, "reentrant");
        locked = 2;
        _;
        locked = 1;
    }

    function deposit() external payable {
        balanceOf[msg.sender] += msg.value;
    }

    function withdraw() external nonReentrant {
        uint256 amount = balanceOf[msg.sender];
        require(amount > 0, "empty");

        balanceOf[msg.sender] = 0;
        (bool ok,) = msg.sender.call{value: amount}("");
        require(ok, "transfer failed");
    }
}
