// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;

contract Immutable {
    
    address public immutable MY_ADDRESS;
    uint public immutable MY_LUCKYNUMBER;

    constructor(uint _myNumber) {
        MY_ADDRESS = msg.sender;
        MY_LUCKYNUMBER = _myNumber;
    }
}