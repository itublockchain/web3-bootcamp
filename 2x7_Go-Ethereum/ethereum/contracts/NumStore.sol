// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract NumStore {
    // Total number added to the contract
    uint256 private total;

    // Get the total number
    function getTotal() external view returns (uint256) {
        return total;
    }

    // Add number to the contract
    function addNumber(uint256 number) external {
        total += number;
    }
}
