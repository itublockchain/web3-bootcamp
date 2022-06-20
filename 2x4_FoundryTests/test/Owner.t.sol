// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Owner.sol";

contract ContractTest is Test {
    Owner ownerContract;
    address newOwner = address(0xBEEF);
    address firstOwner = 0xb4c79daB8f259C7Aee6E5b2Aa729821864227e84;

    function setUp() public {
        ownerContract = new Owner();
    }

    function testFirstOwner() public {
        assertEq(ownerContract.getOwner(), firstOwner);
    }

    function testChangeOwner() public {
        ownerContract.changeOwner(newOwner);
        assertEq(ownerContract.getOwner(), newOwner);
    }

    function testChangeOwnerUnauthorized() public {
        vm.prank(newOwner);
        vm.expectRevert("Caller is not owner");
        ownerContract.changeOwner(newOwner);
    }

}
