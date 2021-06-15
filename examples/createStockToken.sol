// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
import "./stockTocken.sol";

contract createStockToken {
    constructor () {}


 function registerOrder(Side _side, OrderType _type, uint _price, uint _quantity) public validUser(msg.sender) {
       
        User memory user = users[msg.sender];
       
        if (_side == Side.SELL)
            require(theToken.balanceOf(msg.sender) >= _quantity, "Insufficient position size");

        // this only works for limit orders
        if (_side == Side.BUY)
            require(msg.sender.balance >= _quantity * _price, "Insufficient balance");
       
        Order memory newOrder = Order({
            price: _price,
            quantity: _quantity,
            owner: user,
            side: _side,
            orderType: _type
        });
       
        /*  DO WE NEED TO ENTER if it gets matched?
        if (_side == Side.BUY){
            buyOrders[numBuyOrders] = newOrder;
            numBuyOrders += 1;
        }else if (_side == Side.SELL){
            sellOrders[numSellOrders] = newOrder;
            numSellOrders += 1;
        }*/
        matchAndExecute(newOrder);
    }
    function createST()  public {
       StockToken theToken = new StockToken("BraunCoin", "BRC", 1000);
       address tokenIssuer = msg.sender;
       
    }
}