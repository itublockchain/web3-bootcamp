import "./App.css";
import { Navbar } from "./Components";
import { MyNFTs, ListedItems, Home } from "./Pages";
import { useDispatch, useSelector } from "react-redux";
import { BrowserRouter, Route, Routes } from "react-router-dom";


function App() {
  const dispatch = useDispatch();
  const currentAccount = useSelector((state) => state.accounts.account);


  return (
    <div className="Wrapper">
      <BrowserRouter>
        <Navbar />
        {currentAccount ? (
          <Routes>
            <Route path="/" element={<Home />} />
            <Route path="/myprofil" element={<MyNFTs />} />
            <Route path="/listeditems" element={<ListedItems />} />
            <Route path="*" element={<div>Not found</div>} />
          </Routes>
        ) : (
          <div>You Should connect wallet! </div>
        )}
      </BrowserRouter>
      {/* <ListedItems /> */}
    </div>
  );
}

export default App;
