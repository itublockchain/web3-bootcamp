// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;

contract Human {
    function sayHello() public pure virtual returns(string memory) {
        return "itublockchain.com adresi uzerinden kulube uye olabilirsiniz :)";
    }
}

contract SuperHuman is Human {
    function sayHello() public pure override returns(string memory) {
        return "Selamlar itu blockchain uyesi, nasilsin ? :)";
    }

    function welcomeMsg(bool isMember) public pure returns(string memory) {
        return isMember ? sayHello() : super.sayHello();
    }
}
