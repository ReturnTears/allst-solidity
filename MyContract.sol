// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

contract MyContract {
    uint public myNumber;

    constructor(uint _myNumber) {
        myNumber = _myNumber;
    }

    function setMyNumber(uint _myNumber) public {
        myNumber = _myNumber;
    }

    function getMyNumber() public view returns (uint) {
        return myNumber;
    }
}