//SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;

contract IfElse {
    bytes32 private hashedPassord;
    uint256 private loginCount;

    constructor(string memory _password) {
        hashedPassord = keccak256(abi.encode(_password));
    }

    function login(string memory _password) public returns (bool) {
        if (hashedPassord == keccak256(abi.encode(_password))) {
            loginCount++;
            //loginCount += 1;
            return true;
        } else {
            return false;
        }
        // return (hashedPassord == keccak256(abi.encode(_password)));
    }

    function loginlogin(string memory _password) public view returns (uint256) {
        if (hashedPassord == keccak256(abi.encode(_password))) {
            return 1;
        } else {
            return 0;
        }
        // return (hashedPassord == keccak256(abi.encode(_password)) ? 1 : 0);
    }

    function loginStatus() public view returns (uint256) {
        if (loginCount == 0) {
            return 0;
        } else if (loginCount > 0 && loginCount != 1) {
            return 1;
        } else if (loginCount == 1) {
            return 2;
        } else {
            return 3;
        }
    }

    /*
        && -> ve
        true && false -> false
        || -> veya
        true || false -> true
        >, <, >=, <=
    */
}
