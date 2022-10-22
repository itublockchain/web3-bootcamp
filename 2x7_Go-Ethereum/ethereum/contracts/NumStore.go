// Code generated - DO NOT EDIT.
// This file is a generated binding and any manual changes will be lost.

package numstore

import (
	"errors"
	"math/big"
	"strings"

	ethereum "github.com/ethereum/go-ethereum"
	"github.com/ethereum/go-ethereum/accounts/abi"
	"github.com/ethereum/go-ethereum/accounts/abi/bind"
	"github.com/ethereum/go-ethereum/common"
	"github.com/ethereum/go-ethereum/core/types"
	"github.com/ethereum/go-ethereum/event"
)

// Reference imports to suppress errors if they are not otherwise used.
var (
	_ = errors.New
	_ = big.NewInt
	_ = strings.NewReader
	_ = ethereum.NotFound
	_ = bind.Bind
	_ = common.Big1
	_ = types.BloomLookup
	_ = event.NewSubscription
)

// NumstoreMetaData contains all meta data concerning the Numstore contract.
var NumstoreMetaData = &bind.MetaData{
	ABI: "[{\"inputs\":[{\"internalType\":\"uint256\",\"name\":\"number\",\"type\":\"uint256\"}],\"name\":\"addNumber\",\"outputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"getTotal\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"stateMutability\":\"view\",\"type\":\"function\"}]",
}

// NumstoreABI is the input ABI used to generate the binding from.
// Deprecated: Use NumstoreMetaData.ABI instead.
var NumstoreABI = NumstoreMetaData.ABI

// Numstore is an auto generated Go binding around an Ethereum contract.
type Numstore struct {
	NumstoreCaller     // Read-only binding to the contract
	NumstoreTransactor // Write-only binding to the contract
	NumstoreFilterer   // Log filterer for contract events
}

// NumstoreCaller is an auto generated read-only Go binding around an Ethereum contract.
type NumstoreCaller struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// NumstoreTransactor is an auto generated write-only Go binding around an Ethereum contract.
type NumstoreTransactor struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// NumstoreFilterer is an auto generated log filtering Go binding around an Ethereum contract events.
type NumstoreFilterer struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// NumstoreSession is an auto generated Go binding around an Ethereum contract,
// with pre-set call and transact options.
type NumstoreSession struct {
	Contract     *Numstore         // Generic contract binding to set the session for
	CallOpts     bind.CallOpts     // Call options to use throughout this session
	TransactOpts bind.TransactOpts // Transaction auth options to use throughout this session
}

// NumstoreCallerSession is an auto generated read-only Go binding around an Ethereum contract,
// with pre-set call options.
type NumstoreCallerSession struct {
	Contract *NumstoreCaller // Generic contract caller binding to set the session for
	CallOpts bind.CallOpts   // Call options to use throughout this session
}

// NumstoreTransactorSession is an auto generated write-only Go binding around an Ethereum contract,
// with pre-set transact options.
type NumstoreTransactorSession struct {
	Contract     *NumstoreTransactor // Generic contract transactor binding to set the session for
	TransactOpts bind.TransactOpts   // Transaction auth options to use throughout this session
}

// NumstoreRaw is an auto generated low-level Go binding around an Ethereum contract.
type NumstoreRaw struct {
	Contract *Numstore // Generic contract binding to access the raw methods on
}

// NumstoreCallerRaw is an auto generated low-level read-only Go binding around an Ethereum contract.
type NumstoreCallerRaw struct {
	Contract *NumstoreCaller // Generic read-only contract binding to access the raw methods on
}

// NumstoreTransactorRaw is an auto generated low-level write-only Go binding around an Ethereum contract.
type NumstoreTransactorRaw struct {
	Contract *NumstoreTransactor // Generic write-only contract binding to access the raw methods on
}

// NewNumstore creates a new instance of Numstore, bound to a specific deployed contract.
func NewNumstore(address common.Address, backend bind.ContractBackend) (*Numstore, error) {
	contract, err := bindNumstore(address, backend, backend, backend)
	if err != nil {
		return nil, err
	}
	return &Numstore{NumstoreCaller: NumstoreCaller{contract: contract}, NumstoreTransactor: NumstoreTransactor{contract: contract}, NumstoreFilterer: NumstoreFilterer{contract: contract}}, nil
}

// NewNumstoreCaller creates a new read-only instance of Numstore, bound to a specific deployed contract.
func NewNumstoreCaller(address common.Address, caller bind.ContractCaller) (*NumstoreCaller, error) {
	contract, err := bindNumstore(address, caller, nil, nil)
	if err != nil {
		return nil, err
	}
	return &NumstoreCaller{contract: contract}, nil
}

// NewNumstoreTransactor creates a new write-only instance of Numstore, bound to a specific deployed contract.
func NewNumstoreTransactor(address common.Address, transactor bind.ContractTransactor) (*NumstoreTransactor, error) {
	contract, err := bindNumstore(address, nil, transactor, nil)
	if err != nil {
		return nil, err
	}
	return &NumstoreTransactor{contract: contract}, nil
}

// NewNumstoreFilterer creates a new log filterer instance of Numstore, bound to a specific deployed contract.
func NewNumstoreFilterer(address common.Address, filterer bind.ContractFilterer) (*NumstoreFilterer, error) {
	contract, err := bindNumstore(address, nil, nil, filterer)
	if err != nil {
		return nil, err
	}
	return &NumstoreFilterer{contract: contract}, nil
}

// bindNumstore binds a generic wrapper to an already deployed contract.
func bindNumstore(address common.Address, caller bind.ContractCaller, transactor bind.ContractTransactor, filterer bind.ContractFilterer) (*bind.BoundContract, error) {
	parsed, err := abi.JSON(strings.NewReader(NumstoreABI))
	if err != nil {
		return nil, err
	}
	return bind.NewBoundContract(address, parsed, caller, transactor, filterer), nil
}

// Call invokes the (constant) contract method with params as input values and
// sets the output to result. The result type might be a single field for simple
// returns, a slice of interfaces for anonymous returns and a struct for named
// returns.
func (_Numstore *NumstoreRaw) Call(opts *bind.CallOpts, result *[]interface{}, method string, params ...interface{}) error {
	return _Numstore.Contract.NumstoreCaller.contract.Call(opts, result, method, params...)
}

// Transfer initiates a plain transaction to move funds to the contract, calling
// its default method if one is available.
func (_Numstore *NumstoreRaw) Transfer(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _Numstore.Contract.NumstoreTransactor.contract.Transfer(opts)
}

// Transact invokes the (paid) contract method with params as input values.
func (_Numstore *NumstoreRaw) Transact(opts *bind.TransactOpts, method string, params ...interface{}) (*types.Transaction, error) {
	return _Numstore.Contract.NumstoreTransactor.contract.Transact(opts, method, params...)
}

// Call invokes the (constant) contract method with params as input values and
// sets the output to result. The result type might be a single field for simple
// returns, a slice of interfaces for anonymous returns and a struct for named
// returns.
func (_Numstore *NumstoreCallerRaw) Call(opts *bind.CallOpts, result *[]interface{}, method string, params ...interface{}) error {
	return _Numstore.Contract.contract.Call(opts, result, method, params...)
}

// Transfer initiates a plain transaction to move funds to the contract, calling
// its default method if one is available.
func (_Numstore *NumstoreTransactorRaw) Transfer(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _Numstore.Contract.contract.Transfer(opts)
}

// Transact invokes the (paid) contract method with params as input values.
func (_Numstore *NumstoreTransactorRaw) Transact(opts *bind.TransactOpts, method string, params ...interface{}) (*types.Transaction, error) {
	return _Numstore.Contract.contract.Transact(opts, method, params...)
}

// GetTotal is a free data retrieval call binding the contract method 0x775a25e3.
//
// Solidity: function getTotal() view returns(uint256)
func (_Numstore *NumstoreCaller) GetTotal(opts *bind.CallOpts) (*big.Int, error) {
	var out []interface{}
	err := _Numstore.contract.Call(opts, &out, "getTotal")

	if err != nil {
		return *new(*big.Int), err
	}

	out0 := *abi.ConvertType(out[0], new(*big.Int)).(**big.Int)

	return out0, err

}

// GetTotal is a free data retrieval call binding the contract method 0x775a25e3.
//
// Solidity: function getTotal() view returns(uint256)
func (_Numstore *NumstoreSession) GetTotal() (*big.Int, error) {
	return _Numstore.Contract.GetTotal(&_Numstore.CallOpts)
}

// GetTotal is a free data retrieval call binding the contract method 0x775a25e3.
//
// Solidity: function getTotal() view returns(uint256)
func (_Numstore *NumstoreCallerSession) GetTotal() (*big.Int, error) {
	return _Numstore.Contract.GetTotal(&_Numstore.CallOpts)
}

// AddNumber is a paid mutator transaction binding the contract method 0xfce68023.
//
// Solidity: function addNumber(uint256 number) returns()
func (_Numstore *NumstoreTransactor) AddNumber(opts *bind.TransactOpts, number *big.Int) (*types.Transaction, error) {
	return _Numstore.contract.Transact(opts, "addNumber", number)
}

// AddNumber is a paid mutator transaction binding the contract method 0xfce68023.
//
// Solidity: function addNumber(uint256 number) returns()
func (_Numstore *NumstoreSession) AddNumber(number *big.Int) (*types.Transaction, error) {
	return _Numstore.Contract.AddNumber(&_Numstore.TransactOpts, number)
}

// AddNumber is a paid mutator transaction binding the contract method 0xfce68023.
//
// Solidity: function addNumber(uint256 number) returns()
func (_Numstore *NumstoreTransactorSession) AddNumber(number *big.Int) (*types.Transaction, error) {
	return _Numstore.Contract.AddNumber(&_Numstore.TransactOpts, number)
}
