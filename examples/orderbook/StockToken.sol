// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol';

contract stockToken is ERC20 {
 
    constructor (string memory _name, string memory _symbol, address _uid, uint _amount) ERC20(_name,_symbol) {
        _mint (_uid,_amount);
    }   
}