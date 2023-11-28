// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ComplexContract {
    address public owner;
    uint256 private balance;
    mapping(address => uint256) public userBalances;

    event Deposit(address indexed account, uint256 amount);
    event Withdrawal(address indexed account, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    modifier hasBalance(uint256 amount) {
        require(balance >= amount, "Insufficient contract balance");
        _;
    }

    constructor() {
       owner = msg.sender;
    }

    function deposit() external payable {
        require(msg.value > 0, "Deposit amount must be greater than zero");
        balance += msg.value;
        userBalances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint256 amount) external onlyOwner hasBalance(amount) {
        balance -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdrawal(msg.sender, amount);
    }

    function getContractBalance() external view returns (uint256) {
        return balance;
    }

    function getUserBalance() external view returns (uint256) {
        return userBalances[msg.sender];
    }

    function transferOwnership(address newOwner) external onlyOwner {
        require(newOwner != address(0), "Invalid new owner address");
        owner = newOwner;
    }
}
