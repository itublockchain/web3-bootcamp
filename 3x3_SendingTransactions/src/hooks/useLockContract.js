import { useState, useEffect } from "react";
import { ethers } from "ethers";
import { LOCK_ADDRESS } from "../constants/addresses";
import { LOCK_ABI } from "../constants/abi";

export const useLockContract = () => {
  const [contract, setContract] = useState(null);

  useEffect(() => {
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const signer = provider.getSigner();
    const _contract = new ethers.Contract(LOCK_ADDRESS, LOCK_ABI, signer);
    setContract(_contract);
  }, []);

  return contract;
};
