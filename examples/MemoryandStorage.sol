pragma solidity ^0.4.0;

/* This code has a bug in it*/

contract MemoryandStorage {
    mapping (uint => User ) users;
    struct User {
        uint id;
        uint balance;
    }
    constructor () public {
    }
    
    function addUser(uint _id, uint _balance) public {
        users[_id] = User(_id,_balance);
    }
    
    function updateBalance(uint id,uint balance) public view {
        User memory _user = users[id];
        _user.balance = balance;
    }
    
    function getBalance(uint id) public view returns (uint) {
        return users[id].balance;
    }
}
