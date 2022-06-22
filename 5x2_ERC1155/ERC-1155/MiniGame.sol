// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./ERC1155.sol";

contract MiniGame{
    ITUBlockchain char;

    struct gameInfos{
        address gamer1;
        uint gamer1Power;
        address gamer2;
        uint gamer2Power;
        bool isActive;
    }

    uint counter;

    mapping(uint => gameInfos) games;

    uint constant gameFee = 1 ether;

    constructor(ITUBlockchain xd) {
        char = xd;
    }

    function set(ITUBlockchain xd ) public {
        char = xd;
    }

    function startWar() public payable{
        require(char.balanceOf(msg.sender, 0) > 0);
        require(msg.value == gameFee);
        uint health = char.balanceOf(msg.sender, 1);
        uint sword = char.balanceOf(msg.sender, 2);
        uint power = calculatePower(health, sword);
        games[counter] = gameInfos(msg.sender, power, address(this), 0 , true);
        counter += 1;
    }

    function joinWar(uint gameId) public payable{
        require(gameId < counter, "There is no game!");
        require(games[gameId].isActive = true, "War is over!");
        require(games[gameId].gamer1 != msg.sender, "No no no, cheater");
        require(msg.value == gameFee);

        uint health = char.balanceOf(msg.sender, 1);
        uint sword = char.balanceOf(msg.sender, 2);
        uint power = calculatePower(health, sword);

        games[gameId].gamer2 = msg.sender;
        games[gameId].gamer2Power = power;

        whoWin(games[gameId].gamer1Power, games[gameId].gamer2Power) ?
        payable(games[gameId].gamer1).transfer(gameFee * 2) :
        payable(games[gameId].gamer2).transfer(gameFee * 2);

        games[gameId].isActive = false;
    }

    function calculatePower(uint health, uint sword) internal pure returns(uint){
        uint totalHealth = 100 + health;
        return totalHealth / sword;
    }

    function whoWin(uint char1, uint char2) internal pure returns(bool){
        return char1 > char2 ? false : true;
    }
}