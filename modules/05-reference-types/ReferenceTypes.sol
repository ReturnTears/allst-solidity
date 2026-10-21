// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/// @title 引用类型与数据位置
contract ReferenceTypes {
    struct User {
        string name;
        uint256 balance;
    }

    User[] public users;
    bytes public payload;

    function addUser(string calldata name) external {
        users.push(User({name: name, balance: 0}));
    }

    /// @notice storage 引用会直接改合约状态。
    function updateStorage(uint256 index, uint256 balance) external {
        User storage user = users[index];
        user.balance = balance;
    }

    /// @notice 读到 memory 后得到的是副本。
    function copyToMemory(uint256 index) external view returns (string memory name, uint256 balance) {
        User memory user = users[index];
        return (user.name, user.balance);
    }

    function append(bytes calldata chunk) external {
        payload = bytes.concat(payload, chunk);
    }

    function pair(uint256 left, uint256 right) external pure returns (uint256[] memory values) {
        values = new uint256[](2);
        values[0] = left;
        values[1] = right;
    }
}
