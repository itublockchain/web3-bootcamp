package services

import (
	"go-ethereum-tutorial/domain"
	"go-ethereum-tutorial/ethereum"
	errutils "go-ethereum-tutorial/utils/error_utils"
)

type chainService struct{}

type chainServiceInterface interface {
	GetBalance(Q domain.AddressQuery) (*domain.AddressResponse, errutils.ApiError)
	Faucet(r domain.FaucetRequest) (*domain.FaucetResponse, errutils.ApiError)
}

var ChainService chainServiceInterface

func init() {
	ChainService = &chainService{}
}

func (ns *chainService) GetBalance(Q domain.AddressQuery) (*domain.AddressResponse, errutils.ApiError) {
	err := Q.Validate()
	if err != nil {
		return nil, errutils.NewBadRequestError("False input format.")
	}

	request, err := ethereum.ChainInteraction.GetBalance(Q)
	if err != nil {
		return nil, errutils.NewInternalServerError("Balance querying error.")
	}
	return request, nil
}

func (ns *chainService) Faucet(R domain.FaucetRequest) (*domain.FaucetResponse, errutils.ApiError) {
	err := R.Validate()
	if err != nil {
		return nil, errutils.NewBadRequestError("False input format.")
	}

	response, err := ethereum.ChainInteraction.Faucet(R)
	if err != nil {
		return nil, errutils.NewApiError(err.Status(), "ETHs couldn't send.")
	}
	return response, nil
}
