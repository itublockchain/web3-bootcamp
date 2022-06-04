// SPDX-License-Identifier: UNLICENSE
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Purchase.sol";

contract PurchaseTest is Test {
  // Constants
  uint256 constant START_AMOUNT = 0.2 * 10**18;

  // Users
  address seller;
  address buyer;
  address invalidUser;

  // Contracts
  Purchase purchase;

  // Errors
  error OnlyBuyer();
  error OnlySeller();
  error InvalidState();
  error ValueNotEven();

  function setUp() public {
    seller = vm.addr(10);
    buyer = vm.addr(20);
    invalidUser = vm.addr(999);
  }

  function _deploy() private {
    hoax(seller, START_AMOUNT);
    purchase = new Purchase{value: START_AMOUNT }();
  }

  function _confirmPurchase() private {
    hoax(buyer, START_AMOUNT);
    purchase.confirmPurchase{ value: START_AMOUNT }();
  }

  function _confirmReceived() private {
    vm.prank(buyer);
    purchase.confirmReceived();
  }

  function _refundSeller() private {
    vm.prank(seller);
    purchase.refundSeller();
  }

  function testDeploy() public {
    // Tek sayı olan bir değerle deploy etmeye çalışmak revert edecek
    hoax(invalidUser, START_AMOUNT + 1);
    vm.expectRevert(ValueNotEven.selector);
    purchase = new Purchase{value: START_AMOUNT + 1}();

    // Çift sayı olan bir değerle çalışacak
    hoax(seller, START_AMOUNT);
    purchase = new Purchase{value: START_AMOUNT }();

    assertEq(purchase.seller(), seller);
  }

  function testAbort() public {
    _deploy();

    // Eğer başka bir kullanıcı abort etmeye çalışırsa hata alır
    vm.prank(invalidUser);
    vm.expectRevert(OnlySeller.selector);
    purchase.abort();

    // Satıcı çağırırsa çalışır
    vm.prank(seller);
    purchase.abort();

    assertEq(uint256(purchase.state()), 3);
  }

  function testConfirmReceive() public {
    _deploy();

    // Parasını vermeyen kullanıcı satın almayı onaylayamaz
    vm.prank(invalidUser);
    vm.expectRevert();
    purchase.confirmPurchase();

    // Parasını veren kullanıcı satın almayı onaylayabilir
    hoax(buyer, START_AMOUNT);
    purchase.confirmPurchase{ value: START_AMOUNT }();

    // Başarılı bir onaylamadan sonra satın alan kişi kontratta yerini alır
    assertEq(purchase.buyer(), buyer);
  }

  function testClaims() public {
    _deploy();
    _confirmPurchase();

    vm.prank(invalidUser);
    vm.expectRevert(OnlyBuyer.selector);
    purchase.confirmReceived();

    // Satın alan paketin ulaştığını onaylar, satan kişi içerideki parasını
    // geri alır
    vm.prank(buyer);
    purchase.confirmReceived();
    assertEq(buyer.balance, START_AMOUNT / 2);

    vm.prank(seller);
    purchase.refundSeller();
    assertEq(seller.balance, START_AMOUNT * 3 / 2);
  }

  function testWillFail() public {
    _deploy();
    _confirmPurchase();
    _confirmReceived();
    _refundSeller();

    assertEq(uint256(purchase.state()), 0);
  }
}
