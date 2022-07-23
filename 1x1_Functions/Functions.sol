// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract Functions {

    uint luckyNumber = 7;

    function showNumber() public view returns(uint) {
        return luckyNumber;
    }

    function setNumber( uint _newNumber) public {
        luckyNumber = _newNumber;
    }

    function nothing() public pure returns(uint, bool, bool) {
        return (5, true, false);
    }

    function nothing2() public pure returns(uint x, bool y, bool z) {
        x = 5;
        y = true;
        z = false;
    }

}