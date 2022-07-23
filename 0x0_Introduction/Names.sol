// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Names is Ownable {
    string public ownerName;
    string[] public names;
    int256 private luckyNumber;

    constructor(string memory _ownerName, int256 _luckyNumber) {
        ownerName = _ownerName;
        names.push(_ownerName);
        luckyNumber = _luckyNumber;
    }

    function addMyName(string memory _myName) public {
        names.push(_myName);
    }

    function isAdded(string memory _name) public view returns (bool) {
        for (uint256 i = 0; i < names.length; i++) {
            if (
                keccak256(abi.encodePacked((_name))) ==
                keccak256(abi.encodePacked((names[i])))
            ) return true;
        }
        return false;
    }

    function getNames() public view returns (string[] memory) {
        return names;
    }

    function nameCount() public view returns (uint256) {
        return names.length;
    }

    function changeOwnersName(string memory _ownerName) public onlyOwner {
        ownerName = _ownerName;
    }
}
