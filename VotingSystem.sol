// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotingContract {
    address public owner;
    mapping(address => bool) public voters;
    mapping(bytes32 => uint256) public votes;

    event NewVoter(address indexed voter);
    event Voted(address indexed voter, bytes32 candidate);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    modifier onlyVoter() {
        require(voters[msg.sender], "Not a registered voter");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function addVoter(address _voter) external onlyOwner {
        require(_voter != address(0), "Invalid voter address");
        voters[_voter] = true;
        emit NewVoter(_voter);
    }

    function vote(bytes32 candidate) external onlyVoter {
        votes[candidate] += 1;
        emit Voted(msg.sender, candidate);
    }

    function getVoteCount(bytes32 candidate) external view returns (uint256) {
        return votes[candidate];
    }

    function getOwner() external view returns (address) {
        return owner;
    }

    function transferOwnership(address newOwner) external onlyOwner {
        require(newOwner != address(0), "Invalid new owner address");
        owner = newOwner;
    }
}
