import { ethers } from "hardhat";

async function main() {
  const [ signer ] = await ethers.getSigners();
  const SafeRemotePurchase = await ethers.getContractFactory("Purchase");
  const safePurchase = await SafeRemotePurchase.connect(signer).deploy({
    value: ethers.utils.parseEther('0.2')
  });

  await safePurchase.deployed();

  console.log("Safe Purchase deployed to:", safePurchase.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
