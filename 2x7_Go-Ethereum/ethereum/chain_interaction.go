package ethereum

import (
	"go-ethereum-tutorial/domain"
	errutils "go-ethereum-tutorial/utils/error_utils"
)

type chainInteraction struct{}

var ChainInteraction chainInteraction

func (c *chainInteraction) GetBalance(Q domain.AddressQuery) (*domain.AddressResponse, errutils.ApiError) {
	return &domain.AddressResponse{}, nil
}

func (c *chainInteraction) Faucet(R domain.FaucetRequest) (*domain.FaucetResponse, errutils.ApiError) {
	return &domain.FaucetResponse{}, nil
}
