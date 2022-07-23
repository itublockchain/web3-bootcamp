//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Interact {
    address public caller;
    mapping(address => uint256) public counts;

    function callThis() external {
        caller = msg.sender;
        counts[msg.sender]++;
    }
}

contract Pay {
    mapping(address => uint256) public userBalances;

    // receive,  fallback

    function payEth(address _payer) external payable {
        userBalances[_payer] += msg.value;
    }
}

// msg.sender -> A (mesaj yollayan: msg.sender) -> B (mesaj yollayan: A adresi)

contract Caller {
    Interact interact;
    
    constructor(address _interactContract) {
        interact = Interact(_interactContract);
    }

    function callInteract() external {
        interact.callThis();
    }

    function readCaller() external view returns (address) {
        return interact.caller();
    }

    function readCallerCount() public view returns (uint256) {
        return interact.counts(msg.sender);
    }
    
    function payToPay(address _payAddress) public payable {
        Pay pay = Pay(_payAddress);
        pay.payEth{value: msg.value}(msg.sender);

        // Pay(_payAddress).payEth{value: msg.value}(msg.sender);
    }

    function sendEthByTransfer() public payable {
        payable(address(interact)).transfer(msg.value);
    }
}