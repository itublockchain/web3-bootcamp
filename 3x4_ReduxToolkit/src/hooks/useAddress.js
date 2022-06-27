export const useAddress = () => {
  const address = useSelector((state) => state.data.address);
  return address;
};
