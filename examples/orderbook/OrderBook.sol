// SPDX-License-Identifier: MIT

pragma solidity ^ 0.8.0;

import './StockToken.sol';
// import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
// import "@openzeppelin/contracts/utils/Counters.sol";

contract OrderBook {
    
//     Counters.Counter private _tokenIds;
    
    address administrator;
    
    struct User  {
        string userName;
        uint etherBalance;
        stockToken s;
        uint stockAmount;
    }
    
    struct askOrder {
        stockToken s;
        uint amount;
        uint price;
    }
    
    struct bidOrder {
        stockToken s;
        uint amount;
        uint price;
    }
    
    
    mapping (address => stockToken) private stockMap;
    mapping (address => User) public userMap;
    mapping (address => askOrder[]) public askOrderMap;
    mapping (address => bidOrder[]) public bidOrderMap;
    
    event registerAskOrderEvent();
    event registerBidOrderEvent();
    
    
    constructor () {
        administrator = msg.sender;
    }
    
    function getUser(address _useraddr) public view returns (User memory) {
        return (userMap[_useraddr]);
    }
    
    function registerUser(string memory _userName, address  _uid) public returns (bool) {
        
        // Use a function modifier here.
        if (msg.sender != administrator) {
            return false;
        }
        
        userMap[_uid].userName = _userName;
        userMap[_uid].etherBalance = 1000;
       // userMap[_uid] = userStruct;
        return true;
        
    }
    
    
    function addStock(address _uid, uint _amount) public returns (bool) {
        stockToken stoken = new stockToken('Apple, Inc.','AAPL',_uid,_amount);
        stockMap[_uid] = stoken;
        return true;
    }
    
   function registerAskOrder(address _user, uint _amount, uint _price, uint _oid,stockToken _s) public {
        askOrderMap[_user][_oid].s = _s;
        askOrderMap[_user][_oid].amount = _amount;
        askOrderMap[_user][_oid].price = _price;
        emit registerAskOrderEvent();
    }
    
    function registerBidOrder(address _user, uint _amount, uint _price, uint _oid,stockToken _s) public {
        bidOrderMap[_user][_oid].s = _s;
        bidOrderMap[_user][_oid].amount = _amount;
        bidOrderMap[_user][_oid].price = _price;
        emit registerBidOrderEvent();
    }
    

    function executeOrder(address payable _seller, stockToken _s, uint _amount, uint _price) public payable {
        uint totalEtherAmount = _amount * _price;
        uint stockAmountToTransfer = _amount/_price;  // This is bad.  Should be fixed point, not decimal.
        _seller.transfer(totalEtherAmount);
        userMap[msg.sender].etherBalance-= totalEtherAmount;
        userMap[msg.sender].stockAmount += stockAmountToTransfer;
        userMap[_seller].etherBalance += totalEtherAmount;
        userMap[_seller].s.transfer(msg.sender,stockAmountToTransfer);
    }
    
}