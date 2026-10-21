// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ArrayUtils} from "./ArrayUtils.sol";

/// @title 把库函数绑到数组类型上
contract LibraryDemo {
    using ArrayUtils for uint256[];

    uint256[] internal items;

    function add(uint256 value) external {
        items.push(value);
    }

    function length() external view returns (uint256) {
        return items.length;
    }

    function total() external view returns (uint256) {
        return items.sum();
    }

    function has(uint256 value) external view returns (bool) {
        return items.contains(value);
    }

    function sumOf(uint256[] calldata data) external pure returns (uint256) {
        return ArrayUtils.sumMemory(data);
    }
}
