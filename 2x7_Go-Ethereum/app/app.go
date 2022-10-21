package app

import (
	"go-ethereum-tutorial/controllers/club"
	"go-ethereum-tutorial/controllers/chain"
	"go-ethereum-tutorial/controllers/contracts"
)

func mapUrls() {
	router.GET("/", club.Name)

	router.GET("/chain/balance/:address", chain.Balance);
	router.POST("/chain/faucet", chain.Faucet);

	router.GET("/contracts/number", contracts.Number);
	router.POST("/contracts/add", contracts.Add);
}