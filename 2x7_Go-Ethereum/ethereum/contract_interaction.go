package ethereum

import (
	"go-ethereum-tutorial/domain"
	errutils "go-ethereum-tutorial/utils/error_utils"
)

type contractInteraction struct{}

var ContractInteraction contractInteraction

func (c *contractInteraction) GetNumber() (*domain.NumberResponse, errutils.ApiError) {
	return &domain.NumberResponse{}, nil
}

func (c *contractInteraction) AddNumber(R domain.AddRequest) (*domain.AddResponse, errutils.ApiError) {
	return &domain.AddResponse{}, nil
}
