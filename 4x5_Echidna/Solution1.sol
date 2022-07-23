pragma solidity ^0.7.0;

import {Token} from "./Exercise1.sol";

contract Exercise1Test is Token {
  address echidna_caller = msg.sender;

  constructor() public {
    balances[echidna_caller] = 10000;
  }

  function echidna_test_balance() public view returns(bool) {
    // We expect lte 10k, else we should fail
    return balances[echidna_caller] <= 10000;
  }
}
