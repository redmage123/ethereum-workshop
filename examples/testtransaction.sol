pragma solidity ^0.8.0;

contract testContract {
    constructor () payable {
    }
    
    function testTransfer(uint256 amount, address payable _to) payable public {
        _to.transfer(amount);
    }
}