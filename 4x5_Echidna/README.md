# Smart Contract Developer Bootcamp - İTÜ Blockchain

Bu dersimizde fuzzing methodundan ve property based testingden bahsettik.
Fuzzing yapmak için sıkça kullanılan araçlardan biri olan Echidna ile egzersizler 
çözdük.

[Assignment1.md](https://github.com/crytic/building-secure-contracts/blob/master/program-analysis/echidna/Exercise-1.md)
[Exercise1.sol](./Exercise1.sol)
[Solution1.sol](./Solution1.sol)

[Assignment2.md](https://github.com/crytic/building-secure-contracts/blob/master/program-analysis/echidna/Exercise-2.md)
[Exercise2.sol](./Exercise2.sol)
[Solution2.sol](./Solution2.sol)

[Assignment5.md](https://github.com/crytic/building-secure-contracts/blob/master/program-analysis/echidna/Exercise-5.md)
[DamnVulnerableDefi Contracts](https://github.com/tinchoabbate/damn-vulnerable-defi)
[Solution5.sol](./Solution5.sol)

[Slither Github](https://github.com/crytic/slither)
[Slither'ın bulduğu hatalar](https://github.com/crytic/slither/wiki/Detector-Documentation)
[Docker talimatları](https://docs.docker.com/get-docker/)

## Extra - Corpus Collection
Kod kompleksitesi arttıkça Echidna işlemleri revert olarak boşa gidebilir. Bu durumlarda Echidna revert olan işlemleri **corpus** isminde loglarla tutar. Bu corpusları inceleyerek işlemlerinizi optimize edebilirsiniz.

Mesela
```solidity
function doStuff() external {
    require(x < 5);
}
```
koduna yapılan çağrıların çoğu revert olacaktır. Çünkü random bir sayının 5'ten küçük olma ihitmali düşük. Bunu düzeltmek için şu yapılabilir
```solidity
function echidna_doBetter(uint256 input) public returns(bool) {
	input = input % 5;
	doStuff(input); 
}
```
