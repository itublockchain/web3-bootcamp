# Smart Contract Developer Bootcamp - İTÜ Blockchain Devs

Bu dersimizde ERC-20'den sonra ERC-721 token standartını inceledik. ERC-20 ile karşılaştırdıktan sonra OpenZeppelin tarafından hazırlanan standart kontratını inceledik. Ardından da basit bir ERC721 token kontratı yazdık.

<br/>

# ERC-721 token dokümantasyonları

* [OpenZeppelin ERC-721 contract](https://github.com/OpenZeppelin/openzeppelin-contracts/tree/master/contracts/token/ERC721)
* [OpenZeppelin Token Dökümanyasyonu](https://docs.openzeppelin.com/contracts/4.x/tokens)
* [Ethereum Dökümantasyonu](https://ethereum.org/en/developers/docs/standards/tokens/)





### Token URI
Her tokenın kendisine özel olan URI'ın bilgisini verir

``` javascript
    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        _requireMinted(tokenId);
        string memory baseURI = _baseURI();
        return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, tokenId.toString())) : "";
    }
```


### Balance Of
Token sahiplerinin bakiyelerinin sorgulanmasında kullanılır.

``` javascript
    function balanceOf(address account) public view virtual override returns (uint256) {
        return _balances[account];
    }
```

### Owner Of
Token sahibinin adresini verir.

``` javascript
    function ownerOf(uint256 tokenId) public view virtual override returns (address) {
        address owner = _owners[tokenId];
        require(owner != address(0), "ERC721: invalid token ID");
        return owner;
    }
```


### Approve
Kullanıcının tokenlarını harcamak için diğer kullanıcılara hak verilmesini sağlar. Bu 'onaylanmış' miktar, _tokenApprovals'ta saklanır.

``` javascript
    function approve(address to, uint256 tokenId) public virtual override {
        address owner = ERC721.ownerOf(tokenId);
        require(to != owner, "ERC721: approval to current owner");

        require(
            _msgSender() == owner || isApprovedForAll(owner, _msgSender()),
            "ERC721: approve caller is not token owner nor approved for all"
        );

        _approve(to, tokenId);
    }
```

### Get Approved
Bu fonksiyon ile kullanımına onay verilmiş token sorgulanabilir.

``` javascript
    function getApproved(uint256 tokenId) public view virtual override returns (address) {
        _requireMinted(tokenId);

        return _tokenApprovals[tokenId];
    }
```

### Set Approval For All
Kullanıcının tokenlarını harcamak için diğer kullanıcılara hak verilmesini sağlar. Approve'dan farkı sadece bir tokena değil direk bütün tokenlar için hak verilmesini sağlar. Bu 'onaylanmış' miktar, _operatorApprovals'ta saklanır.

``` javascript
    function setApprovalForAll(address operator, bool approved) public virtual override {
        _setApprovalForAll(_msgSender(), operator, approved);
    }
```

### Is Approved For All
Bu fonksiyon ile kullanımına onay verilmiş token sorgulanabilir.

``` javascript
    function isApprovedForAll(address owner, address operator) public view virtual override returns (bool) {
        return _operatorApprovals[owner][operator];
    }
```

### Transfer From
Approve edilmiş haklar üzerinden transfer edilebilmesini sağlayan fonksiyon. Esasen diğer kullanıcıların sizin onayladığınız tokenleri nasıl harcayacağı sorusunun cevabıdır.

``` javascript
    function transferFrom(address from,address to, uint256 tokenId) public virtual override {
        require(_isApprovedOrOwner(_msgSender(), tokenId), "ERC721: caller is not token owner nor approved");
        _transfer(from, to, tokenId);
    }
```


### Safe Transfer From
Bu fonksiyonda aynı transferFrom gibi çalışır. Ondan farkı ise tokenın gönderildiği kontratın ERC721Receiver'a uygun olup olmadığının kontrolünü yapar.

``` javascript
    function safeTransferFrom(address from, address to, uint256 tokenId) public virtual override {
        safeTransferFrom(from, to, tokenId, "");
    }
```
<br/>

[Video İçeriği](https://www.youtube.com/watch?v=zf4orRramo4)

[Proje Dizini](./ERC-721)
