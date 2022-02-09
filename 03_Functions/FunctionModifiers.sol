// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;


contract Functions {
    
    //View

    uint public number = 3;

    function addToX(uint y) public view returns(uint){
        return number + y;
    }

    function addAndView(uint a, uint b) public view returns (uint) {
        return a * (b + 42) + block.timestamp;
    }

    //Pure

    function addAndPure(uint a, uint b) public pure returns (uint) {
        return a * (b + 42);
     }

    function hello() pure public returns(string memory) {
        return 'Hello World!';
    }



}