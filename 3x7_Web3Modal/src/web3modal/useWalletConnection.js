import { ethers } from "ethers";
import Web3Modal from "web3modal";
import { providerOptions } from ".";

const web3Modal = new Web3Modal({
  cacheProvider: false,
  providerOptions,
  theme: "dark",
  disableInjectedProvider: false,
});

export const useWalletConnection = () => {
  const connectWallet = async () => {
    try {
      const connector = await web3Modal.connect();
      const provider = new ethers.providers.Web3Provider(connector);
      const accounts = await provider.listAccounts();
      const network = await provider.getNetwork();

      const signer = await provider.getSigner();
      const address = await signer.getAddress();

      console.log(accounts, network, address);
    } catch (error) {}
  };

  const disconnect = async () => {
    await web3Modal.clearCachedProvider();
    window.location.reload();
  };

  return { connectWallet, disconnect };
};
