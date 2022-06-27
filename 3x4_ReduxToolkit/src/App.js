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

function App() {
  const dispatch = useDispatch();
  const provider = useProvider();
  const signer = useSigner();
  const LockContract = useSelector((state) => state.contracts.lock);
  const [value, setValue] = useState("");

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

  const lock = async () => {
    if (!LockContract) return;
    if (!signer) {
      connect();
    }
    const _value = ethers.utils.parseEther(value);
    const txn = await LockContract.connect(signer).lockTokens(_value);
    await txn.wait();
  };

  return (
    <div className="App">
      <button onClick={connect}>Connect</button>
      <button onClick={lock}>Lock</button>
      <div>
        <input value={value} onChange={(e) => setValue(e.target.value)} />
      </div>
    </div>
  );
}

export default App;
