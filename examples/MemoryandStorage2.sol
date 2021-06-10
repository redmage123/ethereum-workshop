pregma solidity ^0.4.0;

/* This code fixes the bug in version 1*/

contract MemoryandStorage {
    mapping (uint => User ) users;
    struct User {
        uint id;
        uint balance;
    }
    
    
    constructor () public {
    }
    
    function addUser(uint id, uint balance) {
        users[id] = User(id,balance);
    }
    
    function updateBalance(uint _id, uint _balance) public view {
        User storage _user = users[id];
        _user.balance = balance;
    }
    
    function getBalance(uint id) public view returns (uint) {
        return users[id].balance;
    }
}


