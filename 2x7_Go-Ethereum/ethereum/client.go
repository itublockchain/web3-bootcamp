package ethereum

import (
	"context"
	"math/big"
	"github.com/ethereum/go-ethereum/ethclient"
)

var Client *ethclient.Client
var CHAIN_ID *big.Int

func init() {
	var err error
	Client, err = ethclient.Dial("https://api.avax-test.network/ext/bc/C/rpc")
	if err != nil {
		panic(err)
	}

	chainID, err := Client.NetworkID(context.Background())
	if err != nil {
		panic(err)
	}
	CHAIN_ID = chainID
}
