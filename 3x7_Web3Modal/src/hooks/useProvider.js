import { useSelector } from "react-redux";

export const useProvider = () => {
  const provider = useSelector((state) => state.data.provider);
  return provider;
};
