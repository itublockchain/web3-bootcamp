const { MerkleTree } = require('merkletreejs');
const keccak256 = require('keccak256');
const ethers = require('ethers');

let addresses = [
    ["0x4B0897b0513fdC7C541B6d9D7E929C4e5364D2dB", "2"], // address 1 from remix ide allowed to mint 2 
    ["0xdD870fA1b7C4700F2BD7f44238821C26f7392148", "1"], // address 2 from remix ide allowed to mint 1
    ["0x5B38Da6a701c568545dCfcB03FcB875f56beddC4", "1"], // arbitrary address 
    ["0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2", "2"], // arbitrary address  
    ["0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB", "1"], // arbitrary address
    ["0x617F2E2fD72FD9D5503197092aC168c91465E7f2", "1"], // arbitrary address
    ["0x17F6AD8Ef982297579C203069C1DbfFE4348c372", "1"], // arbitrary address
    ["0x5c6B0f7Bf3E7ce046039Bd8FABdfD3f9F5021678", "1"] // arbitrary address
]

console.log("Hash of Address 1 ->", ethers.utils.solidityKeccak256(["address", "uint256"], ["0x5B38Da6a701c568545dCfcB03FcB875f56beddC4", "2"]), "\n");
const leafNodes = addresses.map(arr => ethers.utils.solidityKeccak256(["address", "uint256"], arr), "\n");
console.log("Leaf Nodes ->", leafNodes, "\n");

const merkleTree = new MerkleTree(leafNodes, keccak256, { sortPairs: true });
const rootHash = merkleTree.getHexRoot();
console.log(" │ Merkle Tree\n │\n", merkleTree.toString(), "\n");
console.log("Root Hash ->", rootHash, "\n");

const poa1 = merkleTree.getHexProof(leafNodes[0]);
const poa2 = merkleTree.getHexProof(leafNodes[1]);

console.log("Proof of Address 1 ->", poa1, "\n");
console.log("Proof of Address 2 ->", poa2, "\n");

console.log("Verified :?", merkleTree.verify(poa1, leafNodes[0], rootHash), "\n\n");


