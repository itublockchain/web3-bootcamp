// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts@4.6.0/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.6.0/utils/Strings.sol";


contract ITUBlockchain is ERC721 {
    using Strings for uint256;

    constructor() ERC721("ITU Blockchain", "ITU") {

    }

    function _baseURI() internal pure override returns (string memory) {
        return "ipfs://QmPCDduf9Cbdfd1JvHUxD7srqKTz4MehG6SyeH29SZaFdy/";
    }

    function tokenURI(uint256 tokenId) public view virtual override returns(string memory){
        super.tokenURI;

        ownerOf(tokenId);
        return string(abi.encodePacked(_baseURI(), tokenId.toString(), ".json"));
    }


    function safeMint(address to, uint256 tokenId) public {
        _safeMint(to, tokenId);
    }
}

contract Empty {

}