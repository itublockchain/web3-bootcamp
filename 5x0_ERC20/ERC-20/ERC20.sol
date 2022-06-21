// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts@4.6.0/token/ERC20/ERC20.sol";

contract ITUBlockchain is ERC20 {
    mapping(address => uint) time;
    
    constructor() ERC20("ITU Blockchain", "ITU") {
    }

    function mint(address to) public {
        _mint(to, (block.timestamp - totalSupply()));
    }

    function burn(address from, uint amount) public {
        _burn(from, amount);
    }

    function transfer(address to, uint amount) public virtual override returns(bool){
        require(block.timestamp - time[_msgSender()] > 20);
        time[_msgSender()] = block.timestamp;

        return super.transfer(to, amount);
    }
}
