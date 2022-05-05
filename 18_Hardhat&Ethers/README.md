# Smart Contract Developer Bootcamp - İTÜ Blockchain Devs

Bu dersimizde akıllı kontrat geliştirirken sıklıkla kullanılan frameworklerden [Hardhat](https://hardhat.org/) ve akıllı kontratlar ile etkileşim sağlarken kullandığımız kütüphanelerden [ethers.js](https://docs.ethers.io/v5/) kullanarak bir uygulama geliştireceğiz.

<br/>

# Node Kurulumu

Bu videodaki uygulamayı geliştirmek için öncelkile bilgisayarımızda [Node.js](https://nodejs.org/en/) bulunmalı. Bilgisayarınızda kurulu olup olmadığını, terminalinize aşağıdaki komutu yazarak kontrol edebilirsiniz. Hardhat, Node versiyonunuzun ```16.0```'dan yüksek olması halinde çalışacaktır. Aksi halde güncelleme yapmanız gerekmektedir.

```bash
    node -v
```

Eğer bilgisayarınızda Node.js yüklü değilse [bu](https://nodejs.org/en/download/) bu adresten size uygun versiyonu yükleyebilirsiniz veya Hardhat'in [önerdiği](https://hardhat.org/tutorial/setting-up-the-environment.html) kurulum ve güncelleme yöntemlerini inceleyebilirsiniz.

<br/>

# Hardhat Çalışma Ortamının Kurulumu

* [Hardhat Dökümanyasyonu](https://hardhat.org/getting-started/)
* [Ethers Dökümantasyonu](https://docs.ethers.io/v5/)
* [Waffle Dökümantasyonu](https://ethereum-waffle.readthedocs.io/en/latest/index.html)

### Node Projesinin Başlatılması
```bash
    npm init --yes
```

### Hardhat'in İndirilmesi
```bash
    npm install --save-dev hardhat
```
### Hardhat'in Çalıştırılarak Çalışma Ortamın Yapısının Seçilmesi
```bash
    npx hardhat
```

### Gerekli Eklentilerin Kurulumu ([Ethers.js](https://docs.ethers.io/v5/), [Waffle](https://ethereum-waffle.readthedocs.io/en/latest/index.html))
```bash
    npm install --save-dev @nomiclabs/hardhat-ethers ethers @nomiclabs/hardhat-waffle ethereum-waffle chai

```

### ```hardhat.config.js``` Dosyasının Hazırlanması
```javascript
    //require("@nomiclabs/hardhat-ethers");
    require("@nomiclabs/hardhat-waffle");

    const PRIVATE_KEY = "PRIVATE_KEY";


    module.exports = {
        solidity: "0.8.2",
        networks: {
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

### Dosya Dizinleri
```
    boilerplate/
    ├── hardhat.config.js
    ├── package.json
    ├── package-lock.json
    ├── node_modules
    ├──── contracts/
    ├──── test/
    └──── scripts/

```

### Compile İşlemi
```bash
    npx hardhat compile
```

### OpenZeppelin Kontratlarını Kullanmak için
```bash
    npm install @openzeppelin/contracts
```

### Testlerin Çalıştırılması
```bash
    npx hardhat test
```

### Kontratların Deploy Edilmesi
```bash
    npx hardhat run <deploy-scrpit-path>

    npx hardhat run <deploy-scrpit-path> --network <network-name>

    npx hardhat run scripts/deploy.js --network fuji
```
<br/>

# Yardımcı Fonksiyonlar
### Chai Helpers

``` javascript
    await expect(token.transfer(walletTo.address, 1007)).to.be.reverted;

    expect('0xAb5801a7D398351b8bE11C439e05C5B3259aeC9B').to.be.properAddress;
    expect(token).to.not.be.undefined;

    expect(token.balanceOf("0xAb5801a7D398351b8bE11C439e05C5B3259aeC9B")).to.be.equal(0);
    
    expect(token.balanceOf("0xAb5801a7D398351b8bE11C439e05C5B3259aeC9B")).to.be.greaterThan(0);
```

### Ethers Helpers

``` javascript
    await ethers.getContractFactory("Token");
    await ethers.getSigners();
    ethers.utils.parseEther("100");
    ethers.utils.parseUnits("100", 18);
    ethers.utils.formatEther("1000000000000000000");
    ethers.utils.formatUnits("100", 2);
    ethers.constants.MaxUint256;

    const provider = ethers.provider;
    block_number = await provider.getBlockNumber();
    await provider.getBlock(block_number)
    block_timestamp = block.timestamp;
```

Not: [Ethers Playground](https://playground.ethers.org/)

<br/>

[Video İçeriği]()

[Proje Dizini](./lock-project)

[Boilerplate](./boilerplate)