// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Cheatcodes.sol";

contract ContractTest is Test {
    address alice = address(0xBEEF);

    Cheatcodes CC;

    bytes32 randomPK = 0xf4390b831e81c148424b08398cdd250155923787d8a625747e10c823e6ed4100;
    bytes32 data = 0x0000000000000000000000000000000000000000000000000000000000000025;
    address randomAddress = vm.addr(uint256(randomPK));

    function setUp() public {
        CC = new Cheatcodes();
    }

    function testRecover() public {
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(uint256(randomPK), data);
        address recoveredAddress = ecrecover(data, v, r, s);
        assertEq(recoveredAddress, randomAddress);
    }

    function testPrank() public {
        vm.prank(alice);
        CC.fPrank();
    }

    function testPrankTxOrigin() public {
        vm.prank(address(0), alice);
        CC.fPrankTxOrigin();
    }

    function testDeal() public {
        vm.prank(alice);
        vm.deal(alice, 5 ether);
        CC.fDeal();
    }

    function testWarp() public {
        vm.warp(500000000000);
        CC.fWarp();
    }

    function testRoll() public {
        vm.roll(5000000000000);
        CC.fRoll();
    }
}
