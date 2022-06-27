// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Cheatcodes {
    address alice = address(0xBEEF);

    function fPrank() public view returns (bool) {
        require(msg.sender == alice);
        return true;
    }

    function fPrankTxOrigin() public view returns (bool) {
        require(tx.origin == alice);
        return true;
    }

    function fDeal() public view returns (bool) {
        require(msg.sender.balance == 5 ether);
        return true;
    }

    function fWarp() public view returns (bool) {
        require(block.timestamp > 50000000);
        return true;
    }

    function fRoll() public view returns (bool) {
        require(block.number > 50000000);
        return true;
    }
}
