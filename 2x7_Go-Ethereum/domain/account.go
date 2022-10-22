package domain

import (
	"github.com/ethereum/go-ethereum/accounts/abi/bind"
	"github.com/ethereum/go-ethereum/common"
)

type Account struct {
    FromAddress common.Address
    Auth *bind.TransactOpts
}