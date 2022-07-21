pragma solidity ^0.8.0;

import {Token} from "./Exercise2.sol";

contract Exercise1Test is Token {
  constructor() {
    paused();
    owner = address(0x0); 
  }

  function echidna_cannot_unpause() public view returns(bool) {
    return is_paused;
  }
}
