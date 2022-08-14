// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/structs/BitMaps.sol";
import "./Merkle.sol";

contract MerkleNFT is ERC721 {
    using BitMaps for BitMaps.BitMap;

    bytes32 public merkleRoot;
    BitMaps.BitMap private minted;
    uint256 public lastId;

    constructor(bytes32 root) ERC721("MerkleNFT", "MNFT") {
        merkleRoot = root;
    }

    function wlMint(uint256 amount, bytes32[] calldata merkleProof) external {
        bytes32 leafNode = keccak256(abi.encodePacked(msg.sender, amount));
        (bool v, uint256 i) = MerkleProof.verify(
            merkleProof,
            merkleRoot,
            leafNode
        );
        require(v, "Not matching.");
        require(!minted.get(i), "Already minted.");
        minted.set(i);
        mint(msg.sender, amount);
    }

    function mint(address to, uint256 amount) private {
        for (uint256 i; i < amount; i++) {
            lastId++;
            _safeMint(to, lastId);
        }
    }
}