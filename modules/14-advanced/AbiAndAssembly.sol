// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/// @title ABI 编解码与一段最小汇编
/// @notice 汇编加法不做溢出检查，只用于对照 EVM 的 add 指令。
contract AbiAndAssembly {
    function pack(uint256 value) external pure returns (bytes memory) {
        return abi.encode(value);
    }

    function unpack(bytes calldata data) external pure returns (uint256 value) {
        value = abi.decode(data, (uint256));
    }

    function addUnchecked(uint256 left, uint256 right) external pure returns (uint256 result) {
        assembly {
            result := add(left, right)
        }
    }
}
