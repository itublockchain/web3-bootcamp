package ethereum

import (
	"context"
	"fmt"
	"math/big"
	"go-ethereum-tutorial/domain"
	errutils "go-ethereum-tutorial/utils/error_utils"
	ethutils "go-ethereum-tutorial/utils/ethereum_utils"
	"github.com/ethereum/go-ethereum/core/types"
)

type chainInteraction struct{}

var ChainInteraction chainInteraction

func (c *chainInteraction) GetBalance(Q domain.AddressQuery) (*domain.AddressResponse, errutils.ApiError) {
	balance, err := Client.BalanceAt(context.Background(), Q.Address, nil)
	if err != nil {
		panic(err)
	}

	response := &domain.AddressResponse{Address: Q.Address, Balance: ethutils.ToDecimal(balance, 18)}

	return response, nil
}

func (c *chainInteraction) Faucet(R domain.FaucetRequest) (*domain.FaucetResponse, errutils.ApiError) {
	nonce, err := Client.PendingNonceAt(context.Background(), Account.FromAddress)
	if err != nil {
		return nil, errutils.NewInternalServerError(err.Error())
	}

	tipCap, err := Client.SuggestGasTipCap(context.Background())
	if err != nil {
		return nil, errutils.NewInternalServerError(err.Error())
	}

	feeCap, err := Client.SuggestGasPrice(context.Background())
	if err != nil {
		return nil, errutils.NewInternalServerError(err.Error())
	}

	value := big.NewInt(10000000000000000)
	if R.Amount == 2 {
		value.Mul(value, big.NewInt(2))
	}

	gasLimit := uint64(21000)
	toAddress := R.Address

	tx := types.NewTx(&types.DynamicFeeTx{
		ChainID:   CHAIN_ID,
		Nonce:     nonce,
		GasTipCap: tipCap,
		GasFeeCap: feeCap,
		Gas:       gasLimit,
		To:        &toAddress,
		Value:     value,
		Data:      nil,
	})

	signedTx, err := types.SignTx(tx, types.NewLondonSigner(CHAIN_ID), PrivateECDSA)
	if err != nil {
		return nil, errutils.NewInternalServerError("Tx couldn't signed.")
	}

	err = Client.SendTransaction(context.Background(), signedTx)
	if err != nil {
		return nil, errutils.NewInternalServerError("Tx couldn't send.")
	}

	fmt.Println("tx:", signedTx.Hash().Hex())

	response := &domain.FaucetResponse{Address: R.Address, Amount: ethutils.ToDecimal(value, 18)}

	return response, nil
}
