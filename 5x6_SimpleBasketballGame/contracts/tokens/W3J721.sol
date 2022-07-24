// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

struct Player {
    uint8 attack;
    uint8 defence;
}

contract Web3Jam is ERC721, ERC721Burnable, Ownable {
    mapping(uint256 => Player) public players;
    mapping(address => bool) public authorized;
    uint256 public playerCount;

    constructor() ERC721("Web3Jam", "W3J") {}

    function safeMint(address to) public onlyAuthorized {
        playerCount++;
        (uint8 a, uint8 d) = getPowers();
        players[playerCount] = Player(a, d);
        _safeMint(to, playerCount);
    }
    
    function chAuthStatus(address minter) external onlyOwner {
        authorized[minter] = !authorized[minter];
    }

    function readPlayer(uint256 tokenId) external view returns(Player memory) {
        return players[tokenId];
    }

    function getPowers() private view returns (uint8, uint8) {
        return (
            uint8(uint256(keccak256(abi.encodePacked(msg.sender, playerCount, block.difficulty)))) % 100,
            uint8(uint256(keccak256(abi.encodePacked(msg.sender, playerCount, block.timestamp)))) % 100
        );
    }

    modifier onlyAuthorized() {
        require(authorized[msg.sender] == true, "Caller is not authorized.");
        _;
    }
}