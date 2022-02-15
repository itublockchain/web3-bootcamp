# Smart Contract Developer Bootcamp - İTÜ Blockchain Devs

Bu dersimizde kontrata ve hesaplara transfer yapmanın yollarını inceledik. Receive ve Fallback fonksiyonları inceledik.

`payable`: Ether transfer edebileceğimiz fonskiyon ve adresleri bildirir.

Bir fonksiyona ether göndermek için fonksiyonun `payable` olarak nitelenmiş olması gerekir
```solidity
function fName() public payable {
    /// @dev fonksiyonun işlevleri...
}
```

Bir adrese ether gönderebilmek için adresin `payable` olarak nitelenmiş olması gerekir.
```solidity
function fName() public  {
    payable(0x...).transfer(amount);
}
```

Ether göndermenin 3 farklı yolu:
- `transfer`: 2300 gas, throws error
- `send`: 2300 gas, bool döndürür
- `call`: gas ayarlanabilir, bool döndürür.

Kontratların fonksiyonlar dışında ether alabilmesi için `receive` ya da `fallback` fonksiyonlarından en az birisinin tanımlanmış olması gerekir.
```solidity
receive() external payable {}

fallback() external payable {}
```
Eğer `msg.data` boş ise `receive`, değil ise `fallback` fonksiyonu çalışır.
```solidity
/*
Hangi fonksiyon çağırılacak, fallback() or receive()?

          Ether gönder
               |
         msg.data boş mu?
              / \
           evet hayır
            /     \
receive() var mı?  fallback()
         /   \
       evet hayır
        /      \
    receive()   fallback()
*/


[Video İçeriği](https://www.youtube.com/playlist?list=PLby2HXktGwN4Cof_6a8YwlMrboX8-hs73)

[Sending Ethers](./Bank.sol)