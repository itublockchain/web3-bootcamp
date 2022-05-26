require("@nomiclabs/hardhat-waffle");

const PRIVATE_KEY = "KEY";

module.exports = {
    solidity: "0.8.2",
    networks: {

      hardhat: {
        forking: {
          url: "ALCHEMY_API",
        }
      },

      mainnet: {
        url: `https://api.avax.network/ext/bc/C/rpc`,
          accounts: [`${PRIVATE_KEY}`]
      },
      fuji: {
        url: `https://api.avax-test.network/ext/bc/C/rpc`,
          accounts: [`${PRIVATE_KEY}`]
      }
    }
};