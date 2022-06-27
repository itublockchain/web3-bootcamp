# Smart Contract Developer Bootcamp - İTÜ Blockchain

Bu dersimizde, bir önceki videoda geliştirdiğimiz [projenin](../18_Hardhat%26Ethers/) üzerine eklemeler yaparak Hardhat üzerinde daha ileri seviye konseptleri inceleyeceğiz. Hardhat'in "mainnet forking" ve "zamana dayalı test" imkanlarından faydalanacağız.

<br/>

<img src="./mainnet%20forking%20example.jpeg" alt="mainnet_forking" width="400"/>

### ```hardhat.config.js``` Dosyasının Düzenlenmesi
```javascript
    require("@nomiclabs/hardhat-waffle");

    const PRIVATE_KEY = "KEY";

    module.exports = {
        solidity: "0.8.2",
        networks: {

          hardhat: {
            forking: {
              url: "ALCHEMY_API",
              // blockNumber: 1234567
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
```

### Block Timestamp Alma
``` javascript
    async function getBlockTimestamp() {
        let block_number, block, block_timestamp;

        block_number = await provider.getBlockNumber();;
        block = await provider.getBlock(block_number);
        block_timestamp = block.timestamp;

        return block_timestamp;
    }
```
### Auto-Mining Düzenleme

``` javascript
    await network.provider.send("evm_setAutomine", [false]);

    ...

    let initialTimestamp = await getBlockTimestamp();
    await provider.send('evm_setNextBlockTimestamp', [initialTimestamp + 2]);
    await provider.send('evm_mine');
```

### Zaman Yönetimi

``` javascript
    async function increaseTime(value) {
        await provider.send('evm_increaseTime', [value]);
        await provider.send('evm_mine');
    }
```

### Adres Taklidi

``` javascript
    await hre.network.provider.request({
        method: "hardhat_impersonateAccount",
        params: ["0x770dE306a8E54b31d4eA18AA5aBf3Da1ef571A6C"],
    });

    owner = await ethers.getSigner("0x770dE306a8E54b31d4eA18AA5aBf3Da1ef571A6C");
```

### Mevcut Kontrata Erişme

``` javascript
    let provider = ethers.provider;
    let token = new ethers.Contract("TOKEN_ADDRESS", "token_abi", provider);
```

<br/>

[Video İçeriği](https://www.youtube.com/watch?v=FyaivvNkrBE&ab_channel=ITUBlockchain)

[Proje Dizini](./lock-project-advanced)

[Alchemy Dashboard](https://dashboard.alchemyapi.io/)