// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/// @notice 调用者不是卖家。
/// @param caller 实际调用地址。
error NotSeller(address caller);

/// @notice 当前状态不允许这个操作。
/// @param current 当前状态的枚举序号。
error InvalidState(uint8 current);

/// @title 订单状态示例
/// @notice 把状态变量、函数、修改器、事件、错误、结构体和枚举放在同一份合约里。
contract Purchase {
    enum State {
        Created,
        Locked,
        Inactive
    }

    struct Order {
        address buyer;
        uint256 price;
        State state;
    }

    address public seller;
    Order public order;

    event StateChanged(State newState);
    event Aborted(address seller);

    modifier onlySeller() {
        if (msg.sender != seller) revert NotSeller(msg.sender);
        _;
    }

    constructor() {
        seller = msg.sender;
        order.state = State.Created;
    }

    /// @notice 买家锁定订单并支付报价。
    function lock() external payable {
        if (order.state != State.Created) revert InvalidState(uint8(order.state));
        order.buyer = msg.sender;
        order.price = msg.value;
        order.state = State.Locked;
        emit StateChanged(State.Locked);
    }

    /// @notice 卖家在锁定前取消订单。
    function abort() external onlySeller {
        if (order.state != State.Created) revert InvalidState(uint8(order.state));
        order.state = State.Inactive;
        emit Aborted(msg.sender);
        emit StateChanged(State.Inactive);
    }
}
