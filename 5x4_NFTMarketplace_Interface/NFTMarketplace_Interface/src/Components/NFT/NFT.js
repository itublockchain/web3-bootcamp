import styles from "./NFT.module.scss";
import { parseAddress } from "../../utils/parseAddress";
import { useContractFunctions } from "../../Hooks/useContractFunctions";
import { useState } from "react";
const NFT = ({ type, contractAddress, tokenId, price, deadline, id }) => {
  const { startNFTSale } = useContractFunctions();
  const [fixedPriceInput, setFixedPriceInput] = useState();
  return (
    <div className={styles.wrapper}>
      <div className={styles.image}>
        <div className={styles.addr}>
          Contract: {parseAddress(contractAddress)}
        </div>
        <div className={styles.id}> Token Id: {tokenId}</div>
      </div>
      {type === "bir" ? (
        <div className={styles.type1}>
          <div className={styles.inputPart}>
            <input
              className={styles.input}
              autoComplete="off"
              autoCorrect="off"
              type="text"
              inputMode="decimal"
              pattern="^[0-9]*[.,]?[0-9]*$"
              minLength={1}
              maxLength={79}
              spellCheck="false"
              placeholder={"0.0"}
              onChange={(value) => {
                setFixedPriceInput(Number(value.target.value));
              }}
            />
            <button className={styles.button} onClick={()=>{startNFTSale(contractAddress,fixedPriceInput,tokenId)}}>Fixed Price</button>
          </div>
          <div className={styles.inputPart}>
            <input
              className={styles.input}
              autoComplete="off"
              autoCorrect="off"
              type="text"
              inputMode="decimal"
              pattern="^[0-9]*[.,]?[0-9]*$"
              minLength={1}
              maxLength={79}
              spellCheck="false"
              placeholder={"0.0"}
            />
            <button className={styles.button}>Auction</button>
          </div>
        </div>
      ) : type === "iki" ? (
        <div className={styles.type2}>
          <div>{price} Wei</div>
          <button className={styles.button} onClick={() => buyNFT(id,price)}>Buy </button>
        </div>
      ) : (
        <div className={styles.type3}>
          <div>5 Ether</div>
          <div className={styles.inputPart}>
            <input
              className={styles.input}
              autoComplete="off"
              autoCorrect="off"
              type="text"
              inputMode="decimal"
              pattern="^[0-9]*[.,]?[0-9]*$"
              minLength={1}
              maxLength={79}
              spellCheck="false"
              placeholder={"0.0"}
            />
            <button className={styles.button}>Auction</button>
          </div>
        </div>
      )}
    </div>
  );
};

export { NFT };
