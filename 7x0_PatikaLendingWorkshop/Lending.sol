// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./USD.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Lending is Ownable {
    struct Loan {
        address owner;
        bool borrowed;
        bool closed;
        uint256 amount;
        uint256 deadline;
    }

    USDolar USD;
    Loan[] public orders;
    mapping(uint256 => address) public borrowers;
    
    uint256 constant RATE = 12000;

    event Lend(address owner, uint256 indexed id);
    event Borrow(address owner, uint256 indexed id);
    event Repay(address owner, uint256 indexed id);
    event Withdraw(address owner, uint256 indexed id);
    event Liquidate(address owner, uint256 indexed id);

    constructor(address usdAddress) {
        USD = USDolar(usdAddress);
    }

    receive() external payable {
        revert();
    }

    fallback() external payable {
        revert();
    }

    function lend(uint256 deadline) external payable {
        orders.push(Loan(msg.sender, false, false, msg.value, deadline));
        emit Lend(msg.sender, orders.length - 1);
    }

    function borrow(uint256 id) external {
        Loan memory loan = orders[id];
        require(loan.owner != msg.sender);
        require(!loan.borrowed, "Already borrowed.");
        require(loan.deadline > block.timestamp, "Deadline is over.");

        borrowers[id] = msg.sender;
        orders[id].borrowed = true;

        uint256 amount = calcCollateral(loan.amount);
        USD.transferFrom(msg.sender, address(this), amount);
        payable(msg.sender).transfer(loan.amount);

        emit Borrow(msg.sender, id);

    }

    function repay(uint256 id) external payable {
        Loan storage loan = orders[id];
        require(borrowers[id] == msg.sender, "You are not the borrower.");
        require(loan.amount == msg.value, "Inappropriate repay.");
        require(!loan.closed, "You are liquidated.");

        uint256 amount = calcCollateral(loan.amount);
        uint256 refund = amount * 98 / 100;
        USD.transfer(msg.sender, refund);
        USD.transfer(loan.owner, amount - refund);

        delete(borrowers[id]);
        loan.borrowed = false;

        emit Repay(msg.sender, id);
    }

    function liquidate(uint256 id) external onlyLender(id) {
        Loan memory loan = orders[id];
        require(loan.deadline <= block.timestamp, "Deadline is not over.");

        uint256 amount = loan.amount * RATE;
        USD.transfer(msg.sender, amount);

        delete(borrowers[id]);
        orders[id].closed = true;

        emit Liquidate(msg.sender, id);
    }

    function withdraw(uint256 id) external onlyLender(id) {
        Loan storage loan = orders[id];
        require(!loan.borrowed, "In borrow.");

        loan.closed = true;

        payable(msg.sender).transfer(loan.amount);

        emit Withdraw(msg.sender, id);
    }

    function calcCollateral(uint256 amount) private pure returns(uint256) {
        return amount * RATE;
    }

    modifier onlyLender(uint256 id) {
        require(orders[id].owner == msg.sender, "You are not the position owner.");
        _;
    }
}