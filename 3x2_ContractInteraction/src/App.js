import { BigNumber, ethers } from "ethers";
import { useState } from "react";
import "./App.css";
import { useLockContract } from "./hooks/useLockContract";

function App() {
  const lockContract = useLockContract();
  const [totalLockedAmount, setTotalLockedAmount] = useState(BigNumber.from(0));

  const getTotalLocked = async () => {
    if (!lockContract) return;
    const result = await lockContract.totalLocked();
    setTotalLockedAmount(result);
  };

  return (
    <div className="App">
      <button onClick={getTotalLocked}>Get total locked</button>
      <h1>
        Total locked amount is:{" "}
        {ethers.utils.formatUnits(totalLockedAmount, 18)}
      </h1>
    </div>
  );
}

export default App;
