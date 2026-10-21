// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

error AuctionAlreadyEnded();
error AuctionNotYetEnded();
error BidTooLow(uint256 highestBid);

/// @title 简化竞价
/// @notice 被超过的出价记入待提取余额，由出价者自己取回。
contract SimpleAuction {
    address public seller;
    address public highestBidder;
    uint256 public highestBid;
    uint256 public endTime;
    bool public ended;

    mapping(address => uint256) public pendingReturns;

    event BidPlaced(address indexed bidder, uint256 amount);
    event Withdrawn(address indexed account, uint256 amount);
    event AuctionEnded(address indexed winner, uint256 amount);

    constructor(uint256 biddingSeconds) {
        seller = msg.sender;
        endTime = block.timestamp + biddingSeconds;
    }

    function bid() external payable {
        if (block.timestamp >= endTime) revert AuctionAlreadyEnded();
        if (msg.value <= highestBid) revert BidTooLow(highestBid);

        if (highestBidder != address(0)) {
            pendingReturns[highestBidder] += highestBid;
        }

        highestBidder = msg.sender;
        highestBid = msg.value;
        emit BidPlaced(msg.sender, msg.value);
    }

    function withdraw() external {
        uint256 amount = pendingReturns[msg.sender];
        require(amount > 0, "nothing to withdraw");
        pendingReturns[msg.sender] = 0;

        (bool ok,) = msg.sender.call{value: amount}("");
        require(ok, "transfer failed");
        emit Withdrawn(msg.sender, amount);
    }

    function end() external {
        if (block.timestamp < endTime) revert AuctionNotYetEnded();
        if (ended) revert AuctionAlreadyEnded();
        ended = true;
        pendingReturns[seller] += highestBid;
        emit AuctionEnded(highestBidder, highestBid);
    }
}
