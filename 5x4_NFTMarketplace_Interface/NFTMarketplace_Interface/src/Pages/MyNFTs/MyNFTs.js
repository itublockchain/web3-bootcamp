import styles from "./MyNFTs.module.scss";
import { useGetNFTs } from "../../Hooks/useGetNFTs";
import { useSelector } from "react-redux";
import { useEffect } from "react";
import { NFT } from "../../Components";
const MyNFTs = () => {
  const { getNFTs } = useGetNFTs();
  const nft = useSelector((state) => state.accounts.accNFTs);
  const acc = useSelector((state) => state.accounts.account);

  useEffect(() => {
    const work = async () => {
      getNFTs();
    };
    work();
  }, []);
  useEffect(() => {
    const work = async () => {
      getNFTs();
    };
    work();
  }, [acc]);
  return (
    <div className={styles.wrapper}>
      {nft
        ? nft.ownedNfts.map((item, i) => {
            // console.log(item.media[0].gateway)
            if (item.tokenType === "ERC721") {
              return (
                <NFT
                  type="bir"
                  key={i}
                  contractAddress={item.contract.address}
                  tokenId={item.tokenId}
                  // imageUrl={1}
                  // imageUrl={item.tokenUri.gateway}
                />
              );
            } else {
              return <></>;
            }
            return <NFT type="bir" />;
          })
        : "NFTs Information Is Loading..."}
    </div>
  );
};

export { MyNFTs };
