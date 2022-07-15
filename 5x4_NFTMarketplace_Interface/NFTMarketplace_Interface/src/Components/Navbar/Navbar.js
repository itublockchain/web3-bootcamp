import LOGO from "../../Assets/logo.png";
import styles from "./Navbar.module.scss";
import { useSetAccount } from "../../Hooks/useSetAccount";
import { useSelector } from "react-redux";
import { parseAddress } from "../../utils/parseAddress";
import { BrowserRouter as Router, Switch, Route } from "react-router-dom";
import { Link, useLocation } from "react-router-dom";
const Navbar = () => {
  const { connectAccount } = useSetAccount();

  const account = useSelector((state) => state.accounts.account);

  return (
    <div className={styles.wrapper}>
      <div className={styles.brand}>
        <Link to="/">
          <img src={LOGO} className={styles.logo}></img>
        </Link>
        ITU BLOCKCHAIN MARKETPLACE
      </div>
      <div className={styles.pages}>
        <div className={styles.links}>
          <Link to="/myprofil">My NFTs</Link>
          <Link to="/listeditems">Listed Items</Link>
          <Link to="#">Auctions</Link>
        </div>
      </div>
      <button
        onClick={() => {
          connectAccount();
          console.log(account);
        }}
      >
        {account ? parseAddress(account) : "Connect Wallet"}
      </button>
    </div>
  );
};

export { Navbar };
