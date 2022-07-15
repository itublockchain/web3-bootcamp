# Smart Contract Developer Bootcamp - İTÜ Blockchain

Bu dersimizde en çok kullanılan token standartlarını incelenin ardından, kullanıcıların sahip oldukları NFT'lerin kimseye güvenmeden bir başkasına satabilmesini sağlayan NFT Marketplace kontratını yazdık. Temel amacı marketplace'in tam olarak ne yaptığının anlaşılmasını amaçlayan bu kontratta direk satış ve açık arttırma özellikleri bulunuyor.

<br/>

# NFT Marketplace dokümantasyonları

* [What is NFT Marketplace?](https://www.coindesk.com/tech/2021/07/12/nft-marketplaces-a-beginners-guide/)



### Start NFT Sale
NFT sahibinin NFT'sini belirli bir fiyata satışa çıkarabilmesini sağlayan fonksiyon.

``` javascript
    function startNFTSale(address contractAddress, uint price, uint tokenId) public {
        IERC721 NFT = IERC721(contractAddress);
        require(NFT.ownerOf(tokenId) == msg.sender, "You are not owner of this NFT!");
        NFT.transferFrom(msg.sender, address(this), tokenId);
        idToItemForSale[idForSale] = ItemForSale(contractAddress, msg.sender, msg.sender,price,tokenId,false);
        idForSale += 1;
    }
```


### Start NFT Auction
NFT sahibinin NFT'sini açık arttırma ile satışa çıkarabilmesini sağlayan fonksiyon.

``` javascript
    function startNFTAuction(address contractAddress, uint price, uint tokenId, uint deadline) public {
        IERC721 NFT = IERC721(contractAddress);
        require(NFT.ownerOf(tokenId) == msg.sender, "You are not owner of this NFT!");
        NFT.transferFrom(msg.sender, address(this), tokenId);
        idToItemForAuction[idForAuction] = ItemForAuction(contractAddress, msg.sender, msg.sender,price,0,tokenId,deadline,false);
        idForAuction += 1;
    }
```

### Buy NFT
Satışa çıkarılmış bir NFT'nin istenilen ücreti ödeme şartıyla satın alınabilmesini sağlayan fonksiyon.

``` javascript
    function buyNFT(uint Id) payable public {
        ItemForSale storage info = idToItemForSale[Id];
        require(Id < idForSale);
        require(msg.sender != info.seller, "You are seller");
        require(msg.value == info.price, "Wrong Price!");
        require(info.state == false, "Cannot buy!");
        IERC721 NFT = IERC721(info.contractAddress);
        NFT.transferFrom(address(this), msg.sender, info.tokenId);
        uint price = msg.value * 95 / 100;
        payable(info.seller).transfer(price);
        payable(owner).transfer(msg.value - price);
        info.buyer = msg.sender;
        info.state = true;
    }
```


### Bid
Açık arttırılmaya çıkarılmış bir NFT için bu fonksiyonu kullanarak teklifte bulunabiliriz.

``` javascript
    function bid(uint Id) payable public {
        ItemForAuction storage info = idToItemForAuction[Id];
        require(Id < idForAuction);
        require(msg.sender != info.seller, "You are seller");
        require(msg.sender != info.buyer, "You have highest bid!");
        require(msg.value >= info.startingPrice, "Wrong Price!");
        require(msg.value > info.highestBid, "Wrong Price!");
        require(info.state == false, "Cannot buy!");
        require(block.timestamp < info.deadline, "Deadline!");
        if(info.seller == info.buyer){
            info.buyer = msg.sender;
            info.highestBid = msg.value;
        }else{
            payable(info.buyer).transfer(info.highestBid);
            info.buyer = msg.sender;
            info.highestBid = msg.value;
        }
    }
```

### Finish NFT Auction
Bu fonksiyon ile açık arttırma için belirlenin bitmesinin ardından NFT'nin yeni sahibine, paranında satıcıya gönderilmesi sağlanır.

``` javascript
    function finishNFTAuction(uint Id) payable public {
        ItemForAuction storage info = idToItemForAuction[Id];
        require(Id < idForAuction);
        require(msg.sender == info.buyer, "You have highest bid!");
        require(info.state == false, "Already finished!");
        require(block.timestamp > info.deadline, "Deadline!");
        require(info.buyer != info.seller, "There is no bid!");
        IERC721 NFT = IERC721(info.contractAddress);
        NFT.transferFrom(address(this), msg.sender, info.tokenId);
        uint price = info.highestBid * 95 / 100;
        payable(info.seller).transfer(price);
        payable(owner).transfer(msg.value - price);
        info.state = true;
    }
```

<br/>

[Video İçeriği](https://www.youtube.com/watch?v=zf4orRramo4)

[Proje Dizini](./NFTMarketplace)
