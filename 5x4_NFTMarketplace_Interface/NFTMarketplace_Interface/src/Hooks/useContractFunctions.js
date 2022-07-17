import { ethers } from "ethers";
import { CONTRACT_ADDRESS } from "./../Contract/Constant/Info";
import { ABI, ABI2 } from "./../Contract/Constant/Info";

export const useContractFunctions = () => {
  const provider = new ethers.providers.Web3Provider(window.ethereum);
  const signer = provider.getSigner();
  const contract = new ethers.Contract(CONTRACT_ADDRESS, ABI, signer);

  const startNFTSale = async (_contractAddress, _price, _tokenId) => {
    const contract2 = new ethers.Contract(_contractAddress, ABI2, signer);
    const sitution = await contract2.getApproved(_tokenId);
    console.log(sitution === CONTRACT_ADDRESS.toString());
    if (sitution === CONTRACT_ADDRESS.toString()) {
      await contract.startNFTSale(_contractAddress, _price, _tokenId);
    } else {
      await contract2.approve(CONTRACT_ADDRESS.toString(), _tokenId);
    }
  };
  const buyNFT = async (_id, _price) => {
    console.log(_id, _price);
    await contract.buyNFT(_id, { value: Number(_price) });
  };

  return {
    startNFTSale,
    buyNFT,
  };
};
