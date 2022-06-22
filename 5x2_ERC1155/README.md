# Smart Contract Developer Bootcamp - İTÜ Blockchain Devs

Bu dersimizde ERC-721'den sonra ERC-1155 token standartını inceledik. ERC-20 ve ERC-721 ile karşılaştırdıktan sonra OpenZeppelin tarafından hazırlanan standart kontratını inceledik. Ardından da bir kullanım örneğini görmek adına basit bir oyunda bu tokenı kullandık.

<br/>

# ERC-1155 token dokümantasyonları

* [OpenZeppelin ERC-1155 contract](https://github.com/OpenZeppelin/openzeppelin-contracts/tree/master/contracts/token/ERC1155)
* [OpenZeppelin Token Dökümanyasyonu](https://docs.openzeppelin.com/contracts/4.x/tokens)
* [Ethereum Dökümantasyonu](https://ethereum.org/en/developers/docs/standards/tokens/)





### Token URI
Her tokenın kendisine özel olan URI'ın bilgisini verir

``` javascript
    function uri(uint256) public view virtual override returns (string memory) {
        return _uri;
    }
```


### Balance Of
Token sahiplerinin bakiyelerinin sorgulanmasında kullanılır.

``` javascript
    function balanceOf(address account, uint256 id) public view virtual override returns (uint256) {
        require(account != address(0), "ERC1155: address zero is not a valid owner");
        return _balances[id][account];
    }
```

### Balance Of Batch
For döngüsü içerisinde balanceOf fonksiyonunu kullanarak tek işlemde birden çok token bakiyesini verir.

``` javascript
    function balanceOfBatch(address[] memory accounts, uint256[] memory ids)  public view virtual override returns (uint256[] memory){
        require(accounts.length == ids.length, "ERC1155: accounts and ids length mismatch");
        uint256[] memory batchBalances = new uint256[](accounts.length);
        for (uint256 i = 0; i < accounts.length; ++i) {
            batchBalances[i] = balanceOf(accounts[i], ids[i]);
        }
        return batchBalances;
    }
```


### Set Approval For All
Kullanıcının tokenlarını harcamak için diğer kullanıcılara hak verilmesini sağlar. Bu 'onaylanmış' miktar, _tokenApprovals'ta saklanır.

``` javascript
    function setApprovalForAll(address operator, bool approved) public virtual override {
        _setApprovalForAll(_msgSender(), operator, approved);
    }
```

### Is Approved For All
Bu fonksiyon ile kullanımına onay verilmiş token sorgulanabilir.

``` javascript
    function isApprovedForAll(address account, address operator) public view virtual override returns (bool) {
        return _operatorApprovals[account][operator];
    }
```

### Safe Transfer From
Bu fonksiyonda token transferi için çalışır. Tokenın gönderildiği kontratın ERC721Receiver'a uygun olup olmadığının kontrolünü yapar.

``` javascript
    function safeTransferFrom(address from, address to, uint256 id, uint256 amount, bytes memory data ) public virtual override {
        require(
            from == _msgSender() || isApprovedForAll(from, _msgSender()),
            "ERC1155: caller is not token owner nor approved"
        );
        _safeTransferFrom(from, to, id, amount, data);
    }
```
<br/>

[Video İçeriği](https://www.youtube.com/watch?v=zf4orRramo4)

[Proje Dizini](./ERC-1155)
