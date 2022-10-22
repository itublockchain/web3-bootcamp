# Smart Contract Developer Bootcamp - İTÜ Blockchain

Bu dersimizde, Ethereum'un resmi GoLang implementasyonu olan "Go Ethereum"u kullanarak uygulamalarımıza Ethereum entegrasyonlarımızı nasıl Go kullanarak yapabileceğimizi inceledik.

[Go Ethereum](https://geth.ethereum.org/)

[Go Ethereum Book](https://goethereumbook.org/en/)

[Go pkgs](https://pkg.go.dev/github.com/ethereum/go-ethereum)

[Go pkg 'ethclient' - RPC API](https://pkg.go.dev/github.com/ethereum/go-ethereum/ethclient)

[Go pkg 'common'- Helper fns](https://pkg.go.dev/github.com/ethereum/go-ethereum/common)

[Go pkg 'bind' - Contract bindings](https://pkg.go.dev/github.com/ethereum/go-ethereum/accounts/abi/bind)

[Go pkg 'types' - Ethereum data types](https://pkg.go.dev/github.com/ethereum/go-ethereum/core/types)

[Akıllı kontratlar için gerekli programları yüklemek için](https://goethereumbook.org/en/smart-contract-compile/)

<br/>

```bash
// Generating the abi of the contract
solc --abi ethereum/contracts/NumStore.sol -o build

// Converting abi to GO file
abigen --abi=./build/NumStore.abi --pkg=numstore --out=ethereum/contracts/NumStore.go

// Generates EVM bytecodes of the contract
solc --bin ethereum/contracts/NumStore.sol -o build

// Implements deploy params to GO file
abigen --bin=./build/NumStore.bin --abi=./build/NumStore.abi --pkg=numstore --out=./ethereum/contracts/NumStore.go
```