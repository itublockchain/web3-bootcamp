package chain

import (
	"go-ethereum-tutorial/domain"
	"go-ethereum-tutorial/services"
	errutils "go-ethereum-tutorial/utils/error_utils"

	"github.com/ethereum/go-ethereum/common"
	"github.com/gin-gonic/gin"
	"net/http"
)

func Balance(c *gin.Context) {
	accAddress := common.HexToAddress(c.Param("address"))
	check := domain.AddressQuery{Address: accAddress}

	response, err := services.ChainService.GetBalance(check)
	if err != nil {
		c.JSON(err.Status(), err)
		return
	}

	c.JSON(http.StatusCreated, response)
}

func Faucet(c *gin.Context) {
	var request domain.FaucetRequest
	if err := c.ShouldBindJSON(&request); err != nil {
		apiErr := errutils.NewBadRequestError("Invalid json body")
		c.JSON(apiErr.Status(), apiErr)
		return
	}

	response, apiErr := services.ChainService.Faucet(request)
	if apiErr != nil {
		c.JSON(apiErr.Status(), apiErr)
		return
	}

	c.JSON(http.StatusCreated, response)
}
