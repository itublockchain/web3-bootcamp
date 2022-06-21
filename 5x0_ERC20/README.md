# Smart Contract Developer Bootcamp - İTÜ Blockchain Devs

Bu dersimizde blockchain dünyasında en çok kullanılan kontratlar olan tokenlardan bahsettik. Token türlerinden bahsettikten sonra ERC-20 token kontratını inceledik. Ardından standart ERC-20 kontratını nasıl özelleştirip, onun gerekli durumlarda nasıl kullanılabileceğine dair örnek yaptık.

<br/>

# ERC-20 token dokümantasyonları

* [OpenZeppelin ERC-20 contract](https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/token/ERC20)
* [OpenZeppelin Token Dökümanyasyonu](https://docs.openzeppelin.com/contracts/4.x/tokens)
* [Ethereum Dökümantasyonu](https://ethereum.org/en/developers/docs/standards/tokens/)



### Total Supply
Kaç tane token var? Token mintable olmadıkça sınırlı bir arz ayarlamanız gerekir.

``` javascript
    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }
```

### Transfer
Transfer işlevini çağıran kişiden bir kullanıcıya token transferini gerçekleştir.

``` javascript
    function transfer(address to, uint256 amount) public virtual override returns (bool) {
        address owner = _msgSender();
        _transfer(owner, to, amount);
        return true;
    }
```


### Balance Of
Token sahiplerinin bakiyelerinin sorgulanmasında kullanılır.

``` javascript
    function balanceOf(address account) public view virtual override returns (uint256) {
        return _balances[account];
    }
```


### Approve
Kullanıcının tokenlarını harcamak için diğer kullanıcılara hak verilmesini sağlar. Bu 'onaylanmış' miktar, Allowance'ta saklanır.

``` javascript
    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, amount);
        return true;
    }
```

### Allowance
Bu fonksiyon ile kullanımına onay verilmiş token miktarını sorgulanabilir.

``` javascript
    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return _allowances[owner][spender];
    }
```



### Transfer From
Approve edilmiş haklar üzerinden transfer edilebilmesini sağlayan fonksiyon. Esasen diğer kullanıcıların sizin onayladığınız tokenleri nasıl harcayacağı sorusunun cevabıdır.

``` javascript
    function transferFrom(address from, address to, uint256 amount) public virtual override returns (bool) {
        address spender = _msgSender();
        _spendAllowance(from, spender, amount);
        _transfer(from, to, amount);
        return true;
    }
```

<br/>

[Video İçeriği](https://www.youtube.com/watch?v=qwrJPcqydTE)

[Proje Dizini](./ERC-20)
