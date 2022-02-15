# Smart Contract Developer Bootcamp - İTÜ Blockchain Devs

Bu dersimizde "Constructor, Constant & Immutable" konusunu işledik.

`constructor`: Kontrat deploy edilirken yalnızca bir kere çalışan, daha sonrada bir daha çağırılamayan isteğe bağlı bir fonksiyondur.

```solidity
contract Constructor {
    uint x;

    constructor(uint _x) {
        x = _x;
    }
}
```

`constant`: Değeri değiştirilemeyen değişkenlerdir. Atanan değer kontrat deploy edildikten sonra bir daha değiştirilemez. Gaz maaliyetinden tasarruf sağlayabilir.

`immutable`: Değeri değiştirilemeyen değişkenlerdir. Constant'tan farkı immutable ile işaretlenmiş değişkenin değerinin constructor ile başlangıçta değiştirilebiliyor oluşudur.



[Video İçeriği](https://www.youtube.com/watch?v=XQR2tL4v0_c&list=PLby2HXktGwN4Cof_6a8YwlMrboX8-hs73&index=4)

[Constructor](./Constructor.sol)

[Constant](./Constant.sol)

[Immutable](./Immutable.sol)
