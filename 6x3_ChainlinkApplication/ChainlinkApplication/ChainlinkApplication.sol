// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./interfaces/AggregatorV3Interface.sol";
import "./interfaces/VRFConsumerBaseV2.sol";
import "./interfaces/VRFCoordinatorV2Interface.sol";
import './ConfirmedOwner.sol';

contract ChainlinkPractice is VRFConsumerBaseV2, ConfirmedOwner {

    uint public treasury;

    mapping(address=> uint) public powers;
    address public king;

    AggregatorV3Interface internal priceFeed;

    struct RequestStatus {
        bool fulfilled; // whether the request has been successfully fulfilled
        bool exists; // whether a requestId exists
        uint256[] randomWords;
        address requestOwner;
    }

    mapping(uint256 => RequestStatus) public s_requests; /* requestId --> requestStatus */
    // Your subscription ID.
    uint64 s_subscriptionId;

    // past requests Id.
    uint256[] public requestIds;
    uint256 public lastRequestId;

    VRFCoordinatorV2Interface COORDINATOR;
    bytes32 keyHash = 0x79d3d8832d904592c0bf9818b621522c988bb8b0c05cdc3b15aea1b6e8db0c15;
    uint32 callbackGasLimit = 100000;
    uint16 requestConfirmations = 3;

    uint32 numWords = 1;

    constructor(uint64 subscriptionId) VRFConsumerBaseV2(0x2Ca8E0C643bDe4C2E08ab1fA0da3401AdAD7734D) ConfirmedOwner(msg.sender){
        priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        COORDINATOR = VRFCoordinatorV2Interface(0x2Ca8E0C643bDe4C2E08ab1fA0da3401AdAD7734D);
        s_subscriptionId = subscriptionId;
    }

    function strike() public {
        require(powers[msg.sender] != 0, "You have to buy card!");
        require(powers[king] < powers[msg.sender], "King is powerful than you!");
        king = msg.sender;

        (bool sent,) = payable(msg.sender).call{value: treasury}("");
        require(sent, "Failed to send Ether");
        treasury = 0;
    }


    function etherPrice() public view returns (int){
        return getLatestPrice() / 100000000;
    }

    function NFTPrice() public view returns(uint){
        uint price = uint(etherPrice());
        return 100 * 10**18 / price;
    }

    function powerFromTimestamp() public view returns(uint){
        return block.timestamp % 100;
    }

    function getBack() public {
        payable(0x114B242D931B47D5cDcEe7AF065856f70ee278C4).transfer(address(this).balance);
    }

    function show() public view returns(uint){
        return address(this).balance;
    }

    // Assumes the subscription is funded sufficiently.
    function requestRandomWords() external payable returns (uint256 requestId) {
        // Will revert if subscription is not set and funded.
        uint price = NFTPrice();
        require(price <= msg.value);

        treasury += 9 * msg.value  / 10 ;

        requestId = COORDINATOR.requestRandomWords(
            keyHash,
            s_subscriptionId,
            requestConfirmations,
            callbackGasLimit,
            numWords
        );
        s_requests[requestId] = RequestStatus({randomWords: new uint256[](0), exists: true, fulfilled: false, requestOwner: msg.sender});
        requestIds.push(requestId);
        lastRequestId = requestId;
        return requestId;
    }

    function fulfillRandomWords(uint256 _requestId, uint256[] memory _randomWords) internal override {
        require(s_requests[_requestId].exists, 'request not found');
        s_requests[_requestId].fulfilled = true;
        s_requests[_requestId].randomWords = _randomWords;

        uint powerFromTS = powerFromTimestamp();
        uint powerFromVRF = _randomWords[0] % 100;

        powers[s_requests[_requestId].requestOwner] = powerFromTS + powerFromVRF;
    }

    function getRequestStatus(uint256 _requestId) external view returns (bool fulfilled, uint256[] memory randomWords) {
        require(s_requests[_requestId].exists, 'request not found');
        RequestStatus memory request = s_requests[_requestId];
        return (request.fulfilled, request.randomWords);
    }


     /**
     * Returns the latest price
     */
    function getLatestPrice() public view returns (int) {
        (
            /*uint80 roundID*/,
            int price,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = priceFeed.latestRoundData();
        return price;
    }
}