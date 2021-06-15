// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract StockToken is ERC20 {
   /* tring storage name;
    string storage symbol;
    uint storage initialSupply;
    */
    constructor (string memory  _name, string memory _symbol, uint _initialSupply) ERC20(_name,_symbol)  {
//        nane = _name;
  //      symbol = _symbol;
  //      initialSupply = _initialSupply;
//        tok = new ERC20(name,symbol);
        _mint(msg.sender, _initialSupply);
    }
}
