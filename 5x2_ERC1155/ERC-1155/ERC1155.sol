// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts@4.6.0/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts@4.6.0/access/Ownable.sol";

contract ITUBlockchain is ERC1155, Ownable {
    string public name;
    string public symbol;
    constructor() ERC1155("") {
        name = "ITU Blockchain";
        symbol = "ITU";
    }

    function mint(address account, uint256 id, uint256 amount, bytes memory data)
        public
        payable
    {
        require(id < 3);
        require(msg.value == 1 ether);
        _mint(account, id, amount, data);
    }
}
