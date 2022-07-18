// SPDX-License-Identifer: MIT
pragma solidity ^0.8.0;

import "./tokens/W3J721.sol";

contract Marketplace {
    // 

    constructor(address nftAddress) {
        // Create token instance
    }

    function listPlayer(uint256 tokenId, uint256 price) external {
        // Check the ownership of the player
        // Take the sale price and store it
        // Create a data structure to hold listings
        // Transfer NFT to the Marketplace
    }

    function removeListing(uint256 tokenId) external {
        // Check if the player is listed from the msg.sender
        // Give the player back to the msg.sender
        // Clean listing data

    }

    function buyPlayer(uint256 tokenId) external payable {
        // Check the player is on sale for the msg.value
        // Clean listing data
        // Send the msg.value to the NFT's old owner, but take commision for the game treasury
        // Send the NFT to the new owner
    }

    function changePrice(uint256 tokenId, uint256 price) external {
        // Check if the player is listed from the msg.sender
        // Edit the listing data
    }
}