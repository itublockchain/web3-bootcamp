package ethereum

import (
	"fmt"
	"crypto/ecdsa"
	"go-ethereum-tutorial/domain"
	"github.com/ethereum/go-ethereum/accounts/abi/bind"
	"github.com/ethereum/go-ethereum/crypto"
	"github.com/ethereum/go-ethereum/common"
)

var Account domain.Account

const private_key string = "PRIVATE_KEY"

var PrivateECDSA *ecdsa.PrivateKey

func init() {
	PrivateECDSA = crypto.ToECDSAUnsafe(common.FromHex(private_key))

	publicKey := PrivateECDSA.Public()

	publicKeyECDSA, ok := publicKey.(*ecdsa.PublicKey)
	if !ok {
		fmt.Println("cannot assert type")
	}

	fromAddress := crypto.PubkeyToAddress(*publicKeyECDSA)

	auth, err := bind.NewKeyedTransactorWithChainID(PrivateECDSA, CHAIN_ID)
	if err != nil {
		fmt.Println(err)
	}

	Account = domain.Account{
		FromAddress: fromAddress,
		Auth:        auth,
	}
}
