// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

error NotChairperson(address caller);
error NotAllowed(address voter);
error AlreadyVoted(address voter);

/// @title 简化投票
/// @notice 主席授权、一人一票、按提案计票。
contract Ballot {
    struct Proposal {
        string name;
        uint256 voteCount;
    }

    struct Voter {
        bool voted;
        uint256 vote;
    }

    address public chairperson;
    mapping(address => bool) public allowed;
    mapping(address => Voter) public voters;
    Proposal[] public proposals;

    constructor(string[] memory proposalNames) {
        require(proposalNames.length > 0, "no proposals");
        chairperson = msg.sender;
        allowed[msg.sender] = true;
        for (uint256 i = 0; i < proposalNames.length; i++) {
            proposals.push(Proposal({name: proposalNames[i], voteCount: 0}));
        }
    }

    function giveRight(address voter) external {
        if (msg.sender != chairperson) revert NotChairperson(msg.sender);
        require(voter != address(0), "zero address");
        allowed[voter] = true;
    }

    function vote(uint256 proposal) external {
        if (!allowed[msg.sender]) revert NotAllowed(msg.sender);
        Voter storage sender = voters[msg.sender];
        if (sender.voted) revert AlreadyVoted(msg.sender);

        sender.voted = true;
        sender.vote = proposal;
        proposals[proposal].voteCount += 1;
    }

    function winningProposal() external view returns (uint256 winner) {
        uint256 best;
        for (uint256 i = 0; i < proposals.length; i++) {
            if (proposals[i].voteCount > best) {
                best = proposals[i].voteCount;
                winner = i;
            }
        }
    }
}
