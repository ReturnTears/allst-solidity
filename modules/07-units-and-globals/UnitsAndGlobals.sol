// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/// @title 单位与全局变量
contract UnitsAndGlobals {
    uint256 public constant PRICE = 0.05 ether;
    uint256 public immutable startTime;
    uint256 public immutable endTime;

    /// @param durationDays 从部署时刻起持续的天数。
    constructor(uint256 durationDays) {
        startTime = block.timestamp;
        endTime = block.timestamp + durationDays * 1 days;
    }

    function context() external view returns (address sender, uint256 timestamp, uint256 number, uint256 chainId) {
        return (msg.sender, block.timestamp, block.number, block.chainid);
    }

    function active() external view returns (bool) {
        return block.timestamp >= startTime && block.timestamp < endTime;
    }

    /// @notice 附带的 ETH 必须不少于标价。
    function buy() external payable returns (address buyer, uint256 value) {
        require(msg.value >= PRICE, "price");
        return (msg.sender, msg.value);
    }
}
