import CoinbaseWalletSDK from "@coinbase/wallet-sdk";
import { WalletLinkConnector } from "@web3-react/walletlink-connector";

export const providerOptions = {
  walletlink: {
    package: CoinbaseWalletSDK, // Required
    options: {
      appName: "Your dApp",
      rpc: "https://api.avax-test.network/ext/bc/C/rpc",
    },
  },
};

export const CoinbaseWallet = new WalletLinkConnector({
  url: `https://mainnet.infura.io/v3/${process.env.INFURA_KEY}`,
  appName: "Your dAppName",
  supportedChainIds: [1, 3, 4, 5, 42, 56],
});
