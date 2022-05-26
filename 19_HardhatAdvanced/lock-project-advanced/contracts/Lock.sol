// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "./Token.sol";
import "hardhat/console.sol";

contract Lock {
    BEEToken Token;
    uint256 public lockerCount;
    uint256 public totalLocked;
    mapping(address => uint256) public lockers;
    mapping(address => uint256) public deadline;

    constructor(address tokenAddress) {
        Token = BEEToken(tokenAddress);
    }

    function lockTokens(uint256 amount, uint256 time) external {
        require(amount > 0, "Token amount must be bigger than 0.");
        require(time > 0, "Locking time must be bigger than 0.");
        
         
        if(!(lockers[msg.sender] > 0)) lockerCount++;
        totalLocked += amount;
        lockers[msg.sender] += amount;
        deadline[msg.sender] = block.timestamp + time;

        bool ok = Token.transferFrom(msg.sender, address(this), amount);
        require(ok, "Transfer failed.");
    }

    function withdrawTokens() external {
        require(lockers[msg.sender] > 0, "Not enough token.");
        require(block.timestamp >= deadline[msg.sender], "Deadline is not over.");

        uint256 amount = lockers[msg.sender];
        console.log("<><><>", msg.sender, amount);

        delete(lockers[msg.sender]);
        delete(deadline[msg.sender]);
        totalLocked -= amount;
        lockerCount--;
        require(Token.transfer(msg.sender, amount), "Transfer failed.");
    }
}