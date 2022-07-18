// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Team.sol";

contract Game {
    TeamManagement teams;

    event Result(address indexed user, bool result);

    constructor(address payable teamAddress) {
        teams = TeamManagement(teamAddress);
    }

    function makeMatch(address rivalAddress) external {
        require(teams.hasTeam(msg.sender) && teams.hasTeam(rivalAddress), "No team.");

        Team memory teamA = teams.readTeam(msg.sender);
        Team memory teamB = teams.readTeam(rivalAddress);

        bool win = gameAlgorithm(teamA.attack, teamA.defence, teamB.attack, teamB.defence);

        if(win) {
            teams.incPoints(msg.sender, 2);
        } else {
            teams.incPoints(msg.sender, 1);
        }

        emit Result(msg.sender, win);
    }

    function gameAlgorithm(uint8 aA, uint8 dA, uint8 aB, uint8 dB) private view returns(bool) {
        uint8 aOfA = aA + dB;
        uint8 aOfB = dA + dB;

        uint256 points;
        for(uint256 i = 0; i < 3; i++) {
            if(i != 1) {
                if(rand(aOfA) > aA) continue;
                points++;
            } else {    
                if(rand(aOfB) <= aB) continue;
                points++;
            }
        }

        if(points > 1) return true;
        return false;

    }

    function rand(uint8 range) private view returns(uint8) {
        return uint8(uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender)))) % range;
    }
}
