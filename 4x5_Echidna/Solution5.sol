pragma solidity ^0.8.0;

import "./UnstoppableLender.sol";
import "../DamnValuableToken.sol";

contract UnstoppableLenderEchidna {
  uint256 constant TOKENS_IN_POOL = 1_000_000 ether;
  uint256 constant INITIAL_ATTACKER_TOKEN_BALANCE = 100 ether; 

  DamnValuableToken dvt;
  UnstoppableLender unl;

  constructor() {
    dvt = new DamnValuableToken();
    unl = new UnstoppableLender( address(dvt) );

    dvt.approve(address(unl), TOKENS_IN_POOL);
    unl.depositTokens(TOKENS_IN_POOL);

    dvt.transfer(msg.sender, INITIAL_ATTACKER_TOKEN_BALANCE);
  }

  function receiveTokens(address tokenAddr, uint256 amount) external {
    require(msg.sender == address(unl));
    require(dvt.transfer(msg.sender, amount));
  }

  function echidna_flashLoan() public returns (bool) {
    unl.flashLoan(100);
    return true;
  }
}
