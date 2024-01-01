//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

contract BasicLending {
    address payable private owner;

    constructor() {
        owner = payable(msg.sender);
    }

    mapping(address => uint256) private s_balances;
    mapping(address => uint256) private s_borrowedAmounts;

    function deposit() external payable {
        s_balances[msg.sender] = msg.value;
    }

    function withdraw(uint256 amount) public payable {
        require(s_balances[msg.sender] >= amount);

        payable(msg.sender).transfer(amount);
    }

    function borrow(uint256 amount) public payable {
        require(s_balances[msg.sender] >= amount);

        payable(msg.sender).transfer(amount);

        s_borrowedAmounts[msg.sender] = amount;
    }

    function repay() public payable {
        assert(s_borrowedAmounts[msg.sender] >= msg.value);

        payable(owner).transfer(msg.value);
    }
}
