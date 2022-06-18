// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;

// import "@openzeppelin/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract Wallet is Ownable {
    fallback() payable external {}

    function sendEther(address payable to, uint amount) onlyOwner public {
        to.transfer(amount);
    }

    function showBalance() public view returns(uint) {
        return address(this).balance;
    }
}