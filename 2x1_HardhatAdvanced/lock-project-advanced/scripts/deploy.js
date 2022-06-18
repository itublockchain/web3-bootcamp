const { ethers } = require("hardhat");

async function main() {
    const [deployer] = await ethers.getSigners();

    const Lock = await ethers.getContractFactory("Lock");
    const lock = await Lock.deploy("0xa9d19d5e8712C1899C4344059FD2D873a3e2697E");

    console.log("Contract address:", lock.address);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
