# Smart Contract Developer Bootcamp - İTÜ Blockchain Devs

Bu videomuzda Solidity'nin Inheritance özelliğini inceledik. Beraber "virtual, override, super, is" kelimelerinin ne olduğuna baktık. Openzeppelin Ownable contratına da göz attık.

Solidity çoklu kalıtımı destekleyen bir programlama dilidir. Kontratlar `is` anahtar sözcüğü ile diğer kontratları miras olarak alabilir.

`virtual`: Bir alt kontrat tarafından fonksiyonun geçersiz kılınabileceğini bildiren niteleyicidir.

`override`: Bir üst kontratta bulunan `virtual` ile işaretlenmiş fonksiyonları geçersiz kılmamızı ve tekrardan tanımladığımızı bildiren niteleyicidir. 

Miras sırası önemlidir. C3-linearization kurallarına göre `super` anahtar sözcüğü ile miras alınan kontrata erişebiliriz.

[Video İçeriği](https://www.youtube.com/watch?v=KSrhlrHlti4&list=PLby2HXktGwN4Cof_6a8YwlMrboX8-hs73&index=14)

[Interitance, virtual, override](./Inheritance.sol)

[Super](./SuperHuman.sol)

[Import](./Import.sol)