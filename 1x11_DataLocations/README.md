# Smart Contract Developer Bootcamp - İTÜ Blockchain Devs

Bu derste "Data Locations" konusunu işledik

TLDR;
EVM'de 3 çeşit hafıza alanı (data location) bulunur.
- `storage`: Bu veriler blokzincirde tutulur
- `memory` : Bu veriler fonksiyon çağrıldıktan itibaren EVM tarafından ayrılan özel bir bölgeder tutulur ve fonksiyon bittiğinde silinir.
- `calldata`: Bu veriler fonksiyon çağrılırken, çağrının (transaction) içerisinde tutulur (`msg.data`). Bu veriler sadece okunabilir.

`bytes`, `string`, `uint256[]`, `struct` gibi referans tipleri fonksiyonlarda
kullanılırken bu verilerin hangi hafıza alanından alınacağı belirtilmelidir.

> `calldata` sadece fonksiyon parametreleri için kullanılabilir
> `storage` sadece fonksiyon gövdesinde kullanılabilir

```solidity
function(string memory/calldata parameterString) external {
    string memory/storage bodyString = "";
}
```

[Video İçeriği](https://www.youtube.com/watch?v=MzvzBp9l3y0&list=PLby2HXktGwN4Cof_6a8YwlMrboX8-hs73&index=13)

[Data Locations](./DataLocations.sol)
