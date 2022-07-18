// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./tokens/W3J721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

struct Team {
    bool registered;
    uint8 attack;
    uint8 defence;
    uint256 points;
    uint256[3] players;
}

contract TeamManagement is Ownable {
    Web3Jam playerNFTs;
    address payable gameTreasury;
    mapping(address => Team) public teams;
    mapping(address => bool) public authorized;


    uint256 public constant REGISTRATION_FEE = 1 ether;
    uint256 public constant PLAYER_FEE = 0.2 ether;

    event NewTeam(address user);

    error NonOwner(address user, uint256 player);

    constructor(address nftContract, address payable treasury) {
        playerNFTs = Web3Jam(nftContract);
        gameTreasury = treasury;
    }

    receive() external payable {
        revert();
    }

    fallback() external payable {
        revert();
    }

    function register(uint256[3] calldata players) external payable {
        require(msg.value >= REGISTRATION_FEE, "Inappropriate payment.");
        require(hasTeam(msg.sender), "Already have a team.");

        uint8 attack;
        uint8 defence;

        for(uint256 i = 0; i < 3; i++) {
            if (playerNFTs.ownerOf(players[i]) != msg.sender) revert NonOwner(msg.sender, players[i]);
            playerNFTs.transferFrom(msg.sender, address(this), players[i]);

            Player memory p = playerNFTs.readPlayer(players[i]);

            attack += p.attack / 3;
            defence += p.defence / 3;
        }

        teams[msg.sender] = Team(true, attack, defence, 0, players);
        gameTreasury.transfer(address(this).balance);

        emit NewTeam(msg.sender);
    }


    function readTeam(address user) external view returns(Team memory) {
        return teams[user];
    }

    function buyPlayer() external payable {
        require(msg.value >= PLAYER_FEE, "Inappropriate payment.");
        playerNFTs.safeMint(msg.sender);
        gameTreasury.transfer(address(this).balance);
    }

    function chPlayer(uint256 index, uint256 tokenId) external {
        require(index < 3, "No index.");
        if (playerNFTs.ownerOf(tokenId) != msg.sender) revert NonOwner(msg.sender, tokenId);

        uint256 oldPlayer = teams[msg.sender].players[index];
        teams[msg.sender].players[index] = tokenId;

        teams[msg.sender].attack = teams[msg.sender].attack - 
                                playerNFTs.readPlayer(oldPlayer).attack / 3 + 
                                playerNFTs.readPlayer(tokenId).attack / 3;

        teams[msg.sender].defence = teams[msg.sender].defence - 
                                playerNFTs.readPlayer(oldPlayer).defence / 3 + 
                                playerNFTs.readPlayer(tokenId).defence / 3;
        
        playerNFTs.transferFrom(msg.sender, address(this), tokenId);
        playerNFTs.transferFrom(address(this), msg.sender, oldPlayer);
    
    }

    function incPoints(address user, uint256 point) external onlyAuthorized {
        teams[user].points += point;
    }

    function chAuthStatus(address minter) external onlyOwner {
        authorized[minter] = !authorized[minter];
    }

    function hasTeam(address user) public view returns (bool) {
        return teams[user].registered;
    }

    modifier onlyAuthorized() {
        require(authorized[msg.sender] == true, "Caller is not authorized.");
        _;
    }
}