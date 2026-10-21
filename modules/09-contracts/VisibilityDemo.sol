// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/// @title 可见性、常量、收款函数
contract VisibilityDemo {
    uint256 public constant FEE = 100;
    address public immutable deployer;
    uint256 public value;
    uint256 public received;

    constructor() {
        deployer = msg.sender;
    }

    function set(uint256 nextValue) external {
        value = nextValue;
    }

    function double(uint256 input) public pure returns (uint256) {
        return _double(input);
    }

    function _bump(uint256 input) internal returns (uint256) {
        value += input;
        return value;
    }

    function _double(uint256 input) private pure returns (uint256) {
        return input * 2;
    }

    function deposit() external payable {
        value += msg.value;
    }

    receive() external payable {
        received += msg.value;
    }

    fallback() external payable {
        received += msg.value;
    }
}
