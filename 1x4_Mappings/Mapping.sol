//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Mapping {
    mapping(address => bool) public registered;
    mapping(address => int256) public favNums;

    function register(int256 _favNum) public {
        //require(!registered[msg.sender], "Kullanıcınız daha önce kayıt yaptı.");
        require(!isRegistered(), "Kullaniciniz daha once kayit yapti.");
        registered[msg.sender] = true;
        favNums[msg.sender] = _favNum;
    }

    function isRegistered() public view returns (bool) {
        return registered[msg.sender];
    }

    function deleteRegistered() public {
        require(isRegistered(), "Kullaniciniz kayitli degil.");
        delete (registered[msg.sender]);
        delete (favNums[msg.sender]);
    }
}

contract NestedMapping {
    mapping(address => mapping(address => uint256)) public debts;

    function incDebt(address _borrower, uint256 _amount) public {
        debts[msg.sender][_borrower] += _amount;
    }

    function decDebt(address _borrower, uint256 _amount) public {
        require(debts[msg.sender][_borrower] >= _amount, "Not enough debt.");
        debts[msg.sender][_borrower] -= _amount;
    }

    function getDebt(address _borrower) public view returns (uint256) {
        return debts[msg.sender][_borrower];
    }
}
