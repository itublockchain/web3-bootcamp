//SPDX-License-Identifier: MIT
//@notice it's advanced version of previous parts example
pragma solidity ^0.8.0;

contract Events {

    enum Status {
        Taken,
        Preparing,
        Boxed,
        Shipped
    }

    struct Order {
        address customer;
        string zipCode;
        uint256[] products;
        Status status;
    }

    Order[] public orders;
    address public owner;
    uint256 public txCount;

    event OrderCreated(uint256 _orderId, address indexed _consumer);
    event ZipChanged(uint256 _orderId, string _zipCode);

    constructor() {
        owner = msg.sender;
    }

    function createOrder(string memory _zipCode, uint256[] memory _products) checkProducts(_products) incTx external returns(uint256) {
        Order memory order;
        order.customer = msg.sender;
        order.zipCode = _zipCode;
        order.products = _products;
        order.status = Status.Taken;
        orders.push(order);
        
        emit OrderCreated(orders.length - 1, msg.sender);

        return orders.length - 1;
    }

    function advanceOrder(uint256 _orderId) checkOrderId(_orderId) onlyOwner external {
        Order storage order = orders[_orderId];
        require(order.status != Status.Shipped, "Order is already shipped.");

        if (order.status == Status.Taken) {
            order.status = Status.Preparing;
        } else if (order.status == Status.Preparing) {
            order.status = Status.Boxed;
        } else if (order.status == Status.Boxed) {
            order.status = Status.Shipped;
        }
    }

    function getOrder(uint256 _orderId) checkOrderId(_orderId) external view returns (Order memory) {
        return orders[_orderId];
    }

    function updateZip(uint256 _orderId, string memory _zip) checkOrderId(_orderId) onlyCustomer(_orderId) incTx external {
        Order storage order = orders[_orderId];
        order.zipCode = _zip;

        emit ZipChanged(_orderId, _zip);
    }

    modifier checkProducts(uint256[] memory _products) {
        require(_products.length > 0, "No products.");
        _;
    }

    modifier checkOrderId(uint256 _orderId) {
        require(_orderId < orders.length, "Not a valid order id.");
        _;
    }

    modifier incTx {
        _;
        txCount++;
    }

    modifier onlyOwner {
        require(owner == msg.sender, "You are not authorized.");
        _;
    }

    modifier onlyCustomer(uint256 _orderId) {
        require(orders[_orderId].customer == msg.sender, "You are not the owner of the order.");
        _;
    }

}