import "./App.css";
import { useState } from "react";
import { ethers } from "ethers";

function App() {
  const [account, setAccount] = useState("");
  const [provider, setProvider] = useState(null);

  function connect() {
    if (!window.ethereum) {
      alert("Metamask is not installed");
      return;
    }
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    setProvider(provider);
    provider
      .send("eth_requestAccounts", [])
      .then((accounts) => setAccount(accounts[0]))
      .catch((err) => console.log(err));
    const signer = provider.getSigner();
    signer.getAddress().then((address) => console.log(address));
    console.log(signer);
  }

  return (
    <div className="App">
      <button
        onClick={() => {
          if (account) return;
          connect();
        }}
      >
        {account ? "Connected" : "Connect"}{" "}
      </button>
    </div>
  );
}

export default App;
