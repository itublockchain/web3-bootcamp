import { useDispatch } from "react-redux";
import { setNFTs, setListedNFTs } from "../Store/slicers/accounts";
import { useSelector } from "react-redux";
import { Network, initializeAlchemy, getNftsForOwner } from "@alch/alchemy-sdk";
import { ethers } from "ethers";
import { CONTRACT_ADDRESS } from "./../Contract/Constant/Info";
import { ABI } from "./../Contract/Constant/Info";

export const useGetNFTs = () => {
  const settings = {
    apiKey: "r174G5K6HTMV-DbBmqQfi5oSJrqviby0",
    network: Network.ETH_RINKEBY,
    maxRetries: 10,
  };

  const alchemy = initializeAlchemy(settings);
  const dispatch = useDispatch();
  const account = useSelector((state) => state.accounts.account);
  const listedNFTs = useSelector((state) => state.accounts.listedNFTs);

  const getNFTs = async () => {
    if (account) {
      const nftsForOwner = await getNftsForOwner(alchemy, account);
      dispatch(setNFTs(nftsForOwner));
    }
  };

  const getListedNFTs = async () => {
    if (account) {
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();
      const contract = new ethers.Contract(CONTRACT_ADDRESS, ABI, signer);
      const num = await contract.idForSale();
      if (num == 0) {
        return;
      }
      let array = [];
      for (var i = 0; i < num; i++) {
        let info = await contract.idToItemForSale(i);
        if (!info.state) {
          let newItem = {
            0: info.contractAddress,
            1: info.tokenId.toNumber(),
            2: info.price.toNumber(),
            3: i
          };
          array.push(newItem);
        }
      }
      dispatch(setListedNFTs(array));
    }
  };

  return {
    getNFTs,
    getListedNFTs,
  };
};
