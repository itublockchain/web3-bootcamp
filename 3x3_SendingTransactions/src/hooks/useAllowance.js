import { BigNumber, ethers } from "ethers";
import { useEffect, useState } from "react";
import { ERC20 } from "../constants/abi";
import { BEETOKEN_ADDRESS, LOCK_ADDRESS } from "../constants/addresses";

export const useAllowance = () => {
  const [allowance, setAllowance] = useState(BigNumber.from(0));
  const [isAppoving, setIsApproving] = useState(false);

  const getAllowance = async () => {
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const signer = provider.getSigner();
    const _contract = new ethers.Contract(BEETOKEN_ADDRESS, ERC20, provider);
    const result = await _contract.allowance(signer.getAddress(), LOCK_ADDRESS);
    setAllowance(result);
  };

  useEffect(() => {
    getAllowance();
  }, []);

  const approve = async () => {
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const signer = provider.getSigner();
    const _contract = new ethers.Contract(BEETOKEN_ADDRESS, ERC20, signer);
    setIsApproving(true);
    try {
      const txn = await _contract.approve(
        LOCK_ADDRESS,
        ethers.constants.MaxUint256
      );
      await txn.wait();
      setIsApproving(false);
      getAllowance();
    } catch {
      setIsApproving(false);
    }
  };

  return { isAppoving, allowance, approve };
};
