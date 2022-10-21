package domain

import (
	errutils "go-ethereum-tutorial/utils/error_utils"
	"strconv"
)

type NumberResponse struct {
	Number string `json:"number"`
}

type AddRequest struct {
	Number string `json:"number"`
}

func (r *AddRequest) Validate() errutils.ApiError {
	if _, err := strconv.Atoi(r.Number); err != nil {
		return errutils.NewBadRequestError("Number is not valid.")
	}
	return nil
}

type AddResponse struct {
	Number string `json:"number"`
	Result string `json:"result"`
}
