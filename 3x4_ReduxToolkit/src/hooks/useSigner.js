import { useSelector } from "react-redux";

export const useSigner = () => {
  const signer = useSelector((state) => state.data.signer);
  return signer;
};
