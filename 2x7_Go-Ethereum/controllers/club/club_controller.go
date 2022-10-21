package club

import (
	"github.com/gin-gonic/gin"
	"net/http"
)

func Name(c *gin.Context) {
	c.String(http.StatusOK, "ITU Blockchain\n")
}
