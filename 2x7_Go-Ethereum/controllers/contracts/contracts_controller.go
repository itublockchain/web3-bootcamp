package contracts

import (
	"go-ethereum-tutorial/domain"
	"go-ethereum-tutorial/services"
	errutils "go-ethereum-tutorial/utils/error_utils"

	"github.com/gin-gonic/gin"
	"net/http"
)

func Number(c *gin.Context) {
	response, err := services.ContractService.GetNumber()
	if err != nil {
		c.JSON(err.Status(), err)
		return
	}

	c.JSON(http.StatusCreated, response)

}

func Add(c *gin.Context) {
	var request domain.AddRequest
	if err := c.ShouldBindJSON(&request); err != nil {
		apiErr := errutils.NewBadRequestError("Invalid json body")
		c.JSON(apiErr.Status(), apiErr)
		return
	}

	response, apiErr := services.ContractService.AddNumber(request)
	if apiErr != nil {
		c.JSON(apiErr.Status(), apiErr)
		return
	}

	c.JSON(http.StatusCreated, response)
}
