package domain

import (
	"github.com/ethereum/go-ethereum/common"
	errutils "go-ethereum-tutorial/utils/error_utils"
	ethutils "go-ethereum-tutorial/utils/ethereum_utils"
)

type AddressQuery struct {
	Address common.Address `json:"user_addr"`
}

func (q *AddressQuery) Validate() errutils.ApiError {
	if !ethutils.IsValidAddress(q.Address) {
		err := errutils.NewBadRequestError("Invalid address")
		return err
	}
	return nil
}

type AddressResponse struct {
	Address common.Address `json:"user_addr"`
	Balance string         `json:"balance"`
}

type FaucetRequest struct {
	Address common.Address `json:"user_addr"`
	Amount  uint           `json:"amount"`
}

func (r *FaucetRequest) Validate() errutils.ApiError {
	if !ethutils.IsValidAddress(r.Address) {
		apiErr := errutils.NewBadRequestError("Invalid address")
		return apiErr
	}
	if !(r.Amount > 0 && r.Amount <= 2) {
		apiErr := errutils.NewBadRequestError("Invalid amount")
		return apiErr
	}
	return nil
}

type FaucetResponse struct {
	Address common.Address `json:"user_addr"`
	Amount  uint           `json:"amount"`
	Balance string         `json:"balance"`
}
