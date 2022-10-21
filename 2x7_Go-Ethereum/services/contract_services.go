package services

import (
	"go-ethereum-tutorial/domain"
	"go-ethereum-tutorial/ethereum"
	errutils "go-ethereum-tutorial/utils/error_utils"
)

type contractService struct{}

type contractServiceInterface interface {
	GetNumber() (*domain.NumberResponse, errutils.ApiError)
	AddNumber(R domain.AddRequest) (*domain.AddResponse, errutils.ApiError)
}

var ContractService contractServiceInterface

func init() {
	ContractService = &contractService{}
}

func (cs *contractService) GetNumber() (*domain.NumberResponse, errutils.ApiError) {
	request, err := ethereum.ContractInteraction.GetNumber()
	if err != nil {
		return nil, errutils.NewInternalServerError("Number querying error.")
	}
	return request, nil
}

func (cs *contractService) AddNumber(R domain.AddRequest) (*domain.AddResponse, errutils.ApiError) {
	R.Validate()

	response, err := ethereum.ContractInteraction.AddNumber(R)
	if err != nil {
		return nil, errutils.NewApiError(err.Status(), "Number couldn't add.")
	}
	return response, nil
}
