import styles from "./ListedItems.module.scss";
import { useSelector } from "react-redux";
import { useEffect, useState } from "react";
import { NFT } from "../../Components";
import { ethers } from "ethers";
import { CONTRACT_ADDRESS } from "../../Contract/Constant/Info";
import { ABI } from "../../Contract/Constant/Info";
import { useGetNFTs } from "../../Hooks/useGetNFTs";

const ListedItems = () => {
  const acc = useSelector((state) => state.accounts.account);
  const listeditems = useSelector((state) => state.accounts.listedNFTs);
  const { getListedNFTs } = useGetNFTs();
  useEffect(() => {
    const work = async () => {
      getListedNFTs();
    };
    work();
  }, []);

  return (
    <div className={styles.wrapper}>
      {listeditems.length > 0
        ? listeditems.map((item, i) => {
            return (
              <NFT
                key={i}
                type="iki"
                contractAddress={item[0]}
                tokenId={item[1]}
                price={item[2]}
                id={item[3]}
              />
            );
          })
        : "Listed NFTs Information Is Loading..."}
    </div>
  );
};

export { ListedItems };
