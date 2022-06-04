// SPDX-License-Identifier: UNLICENSE
pragma solidity ^0.8.13;

import "../src/Purchase.sol";
import "forge-std/Script.sol";

contract Deploy is Script {
    uint256 constant START_AMOUNT = 0.2 ether;

    function run() public {
        vm.startBroadcast(0x66c30924155b1deE8a9829C0b0886D93bE44e168);
        new Purchase{ value: START_AMOUNT }();
    }
}