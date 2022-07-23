// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Constructor{
    
    string public tokenName;
    uint public totalSupply;

    constructor(string memory name, uint number) {
        tokenName = name;
        totalSupply = number;
    }

    function set(uint number) public {
        totalSupply = number;
    }
}