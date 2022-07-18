import { useEffect, useState } from "react";
import { batch, useDispatch, useSelector } from "react-redux";
import "./App.css";
import {
  setAccount,
  setAddress,
  setProvider,
  setSigner,
} from "./store/slicers/data";
import { ethers } from "ethers";
import { LOCK_ADDRESS, BEETOKEN_ADDRESS } from "./constants/addresses";
import { LOCK_ABI, ERC20 } from "./constants/abi";
import {
  setBeeTokenContract,
  setLockContract,
} from "./store/slicers/contracts";
import { useProvider } from "./hooks/useProvider";
import { useSigner } from "./hooks/useSigner";
import { useWalletConnection } from "./web3modal/useWalletConnection";

function App() {
  const dispatch = useDispatch();
  const provider = useProvider();
  const signer = useSigner();
  const LockContract = useSelector((state) => state.contracts.lock);
  const { connectWallet } = useWalletConnection();

  useEffect(() => {
    if (!window.ethereum) {
      alert("Metamask is not installed");
      return;
    }
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const LockContract = new ethers.Contract(LOCK_ADDRESS, LOCK_ABI, provider);
    const BeeTokenContract = new ethers.Contract(
      BEETOKEN_ADDRESS,
      ERC20,
      provider
    );
    batch(() => {
      dispatch(setProvider(provider));
      dispatch(setLockContract(LockContract));
      dispatch(setBeeTokenContract(BeeTokenContract));
    });
  }, []);

  function connect() {
    if (!provider) return;
    provider
      .send("eth_requestAccounts", [])
      .then((accounts) => dispatch(setAccount(accounts[0])))
      .catch((err) => console.log(err));
    const signer = provider.getSigner();
    signer.getAddress().then((address) => {
      batch(() => {
        dispatch(setSigner(signer));
        dispatch(setAddress(address));
      });
    });
  }

  function connectWeb3Modal() {
    connectWallet();
  }

  useEffect(() => {
    if (!LockContract) return;

    const listener = (sender, amount) => {
      console.log(sender, amount);
    };
    LockContract.on("Locked", listener);

    return () => {
      LockContract?.off("Locked", listener);
    };
  }, [LockContract]);

  const addAsset = async () => {
    if (!window.ethereum) return;

    const tokenAddress = "0xd00981105e61274c8a5cd5a88fe7e037d935b513";
    const tokenSymbol = "TUT";
    const tokenDecimals = 18;
    const tokenImage = "http://placekitten.com/200/300";

    try {
      // wasAdded is a boolean. Like any RPC method, an error may be thrown.
      const wasAdded = await window.ethereum.request({
        method: "wallet_watchAsset",
        params: {
          type: "ERC20", // Initially only supports ERC20, but eventually more!
          options: {
            address: tokenAddress, // The address that the token is at.
            symbol: tokenSymbol, // A ticker symbol or shorthand, up to 5 chars.
            decimals: tokenDecimals, // The number of decimals in the token
            image: tokenImage, // A string url of the token logo
          },
        },
      });

      if (wasAdded) {
        console.log("Thanks for your interest!");
      } else {
        console.log("Your loss!");
      }
    } catch (error) {
      console.log(error);
    }
  };

  return (
    <div className="App">
      <button onClick={connect}>Connect</button>
      <button onClick={addAsset}>Add TUT Token</button>
      <button onClick={connectWeb3Modal}>Connect Web3 Modal</button>
    </div>
  );
}

export default App;
