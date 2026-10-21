// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/// @notice 数值必须是偶数。
error NotEven(uint256 value);

/// @notice 供外部调用的回声合约。
contract Echo {
    function echo(uint256 x) external pure returns (uint256) {
        return x * 2;
    }
}

/// @title 控制流、回滚、溢出检查和 new
contract ControlFlow {
    function sumTo(uint256 n) external pure returns (uint256 total) {
        require(n <= 100, "n too large");
        for (uint256 i = 1; i <= n; i++) {
            total += i;
        }
    }

    function onlyPositive(uint256 n) external pure returns (uint256) {
        require(n > 0, "n must be positive");
        return n;
    }

    function mustBeEven(uint256 n) external pure returns (uint256) {
        if (n % 2 != 0) revert NotEven(n);
        return n;
    }

    function checkedAdd(uint256 a, uint256 b) external pure returns (uint256) {
        return a + b;
    }

    function uncheckedAdd(uint256 a, uint256 b) external pure returns (uint256 result) {
        unchecked {
            result = a + b;
        }
    }

    function createEcho() external returns (Echo created) {
        created = new Echo();
    }

    function tryDouble(Echo target, uint256 x) external pure returns (uint256 result, bool success) {
        try target.echo(x) returns (uint256 value) {
            return (value, true);
        } catch {
            return (0, false);
        }
    }
}
