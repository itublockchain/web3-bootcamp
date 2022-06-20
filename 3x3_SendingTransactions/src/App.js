import { useState } from "react";
import "./App.css";
import { useLockContract } from "./hooks/useLockContract";
import { ethers } from "ethers";
import { useAllowance } from "./hooks/useAllowance";
import { formatEther } from "ethers/lib/utils";

function App() {
  const contract = useLockContract();
  const [value, setValue] = useState("");
  const [isLocking, setIsLocking] = useState(false);
  const { approve, allowance, isAppoving } = useAllowance();

  const lock = async () => {
    const _value = ethers.utils.parseEther(value);
    setIsLocking(true);
    try {
      const txn = await contract.lockTokens(_value);
      await txn.wait();
      setIsLocking(false);
    } catch {
      setIsLocking(false);
    }
  };

  const withdrawTokens = async () => {
    const txn = await contract.withdrawTokens();
    await txn.wait();
  };

  return (
    <div className="App">
      <input
        placeholder="Enter value"
        value={value}
        onChange={(e) => setValue(e.target.value)}
      />
      <button onClick={lock}>Lock tokens</button>
      <button onClick={approve}>Approve</button>
      <button onClick={withdrawTokens}>Withdraw</button>
      <div>
        <h4>Allowance: {formatEther(allowance)}</h4>
        <p>{isAppoving ? "Approving..." : ""}</p>
        <p>{isLocking ? "Locking..." : ""}</p>
      </div>
    </div>
  );
}

export default App;
