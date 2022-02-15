# Smart Contract Developer Bootcamp - İTÜ Blockchain Devs

Bu dersimizde "Variables & Scopes" konusunu işledik. Ardından Solidity'de kod yazma sürecinde işimizi kolaylaştıran birimlere göz attık.

Solidity'deki değişkenleri üç sınıfa ayırabiliriz:

1- Sabit Boyutlu Türler(Fixed Size Types):
- `bool`: Mantık değişkenidir. `true` ve `false` değerlerini tutar. Varsayılan olarak `false`'dur.
- `int`: Sayıları tuttuğumuz değişkendir. 
- `uint`: Sayıları tuttuğumuz değişkendir. `int`'den farkı negatif sayıların dahil olmamasıdır. 
- `address`: Cüzdan adreslerin tuttuğumuz değişkendir. Boyutu sabit 20 bytes'dır, 
- `bytes32`: String değerleri hexadecimal olarak tutan değişkendir. 

2- Dinamik Boyutlu Türler(Dinamic Size Types):
- `string`: String değerleri tuttuğumuz değişkendir. 
- `bytes`: String değerleri hexadecimal olarak tutan değişkendir. 
- `type[]`: Verileri liste olarak tuttuğumuz değişkendir. Örneğin: [1,2,3,4,5]
- `mapping(type => type)`: Verileri key,value olarak tutmamızı sağlayan değişkendir.

3-Kullanıcı Tanımlı Türler(User Defined Value Types):
- `struct` 
- `enum`

Operatörler:
- `!` (mantıksal olumsuzlama)
- `&&` (mantıksal bağlaç, "ve")
- `||` (mantıksal ayrılma, "veya")
- `==` (eşitlik)
- `!=` (eşitsizlik)

Ether Birimleri
- `1 wei` = 1
- `1 gwei` = 10^9 wei = 1000000000
- `1 ether` = 10^18 wei = 1000000000000000000

Zaman Birimleri 
- `1 seconds` = 1
- `1 minutes` = 60
- `1 hours` = 3600
- `1 days` = 86400
- `1 weeks` = 604800


Solidity'de 3 tür değişken vardır:

1-Yerel(Local):
- Blockchain'de saklanmaz.
- Fonksiyon içerisinde bildirilir.

2-Durum(State):
- Fonksiyon dışında bildirilir.
- Blockchain'de saklanır.

3-Global:
- Blockchain ile ilgili değişkenler


[Video İçeriği](https://www.youtube.com/watch?v=qE6-H1NBraw&list=PLby2HXktGwN4Cof_6a8YwlMrboX8-hs73&index=2)

[Variables and Scope](./Variables.sol)
