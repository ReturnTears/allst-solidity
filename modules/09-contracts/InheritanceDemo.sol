// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

interface ICounter {
    function increment() external;

    function count() external view returns (uint256);
}

abstract contract BaseCounter is ICounter {
    uint256 public count;

    function increment() public virtual {
        count += 1;
    }
}

/// @title 按构造参数指定的步长递增
contract StepCounter is BaseCounter {
    uint256 public step;

    constructor(uint256 step_) {
        step = step_ == 0 ? 1 : step_;
    }

    function increment() public override {
        count += step;
    }
}
