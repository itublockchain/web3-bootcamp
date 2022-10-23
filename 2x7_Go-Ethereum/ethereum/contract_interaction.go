package ethereum

import (
	"context"
	"fmt"
	"math/big"
	"strconv"
	"time"
	"go-ethereum-tutorial/domain"
	"go-ethereum-tutorial/ethereum/contracts"
	errutils "go-ethereum-tutorial/utils/error_utils"
	"github.com/ethereum/go-ethereum/core/types"
	"github.com/ethereum/go-ethereum/common"
	"github.com/ethereum/go-ethereum/ethclient"
)

type contractInteraction struct{}

var ContractInteraction contractInteraction

const CONTRACT_ADDRESS string = "0x5fdE8808a25ea3c4DE959081b225661363b2B11a"

var contract_address common.Address = common.HexToAddress(CONTRACT_ADDRESS)

var Instance *numstore.Numstore

func init() {
	instance, err := numstore.NewNumstore(contract_address, Client)
	if err != nil {
		fmt.Println(err)
	}

	Instance = instance
}

func (c *contractInteraction) GetNumber() (*domain.NumberResponse, errutils.ApiError) {
	total, err := Instance.GetTotal(nil)
	if err != nil {
		return nil, errutils.NewInternalServerError("Contract couldn't be queried")
	}

	response := &domain.NumberResponse{Number: total.String()}

	return response, nil
}

func (c *contractInteraction) AddNumber(R domain.AddRequest) (*domain.AddResponse, errutils.ApiError) {
	nonce, err := Client.PendingNonceAt(context.Background(), Account.FromAddress)
	if err != nil {
		return nil, errutils.NewInternalServerError(err.Error())
	}

	gasPrice, err := Client.SuggestGasPrice(context.Background())
	if err != nil {
		return nil, errutils.NewInternalServerError(err.Error())
	}

	auth := Account.Auth

	auth.Nonce = big.NewInt(int64(nonce))
	auth.Value = big.NewInt(0)
	auth.GasLimit = uint64(300000)
	auth.GasPrice = gasPrice

	var response *domain.AddResponse = &domain.AddResponse{}

	if num, err := strconv.Atoi(R.Number); err != nil {
		return nil, errutils.NewInternalServerError("Validation error.")
	} else {
		addnum := big.NewInt((int64(num)))
		tx, err := Instance.AddNumber(auth, addnum)
		if err != nil {
			return nil, errutils.NewInternalServerError(err.Error())
		}
		response.Number = R.Number

		<-waitTxConfirmed(context.Background(), Client, tx.Hash())
	}

	total, err := Instance.GetTotal(nil)
	if err != nil {
		return nil, errutils.NewInternalServerError("Contract couldn't be queried")
	}

	response.Result = total.String()

	return response, nil
}

func waitTxConfirmed(ctx context.Context, c *ethclient.Client, hash common.Hash) <-chan *types.Transaction {
	ch := make(chan *types.Transaction)

	go func() {
		for {
			tx, pending, _ := c.TransactionByHash(ctx, hash)
			if !pending && tx != nil {
				ch <- tx
			}
			time.Sleep(time.Millisecond * 500)
		}
	}()

	return ch
}
