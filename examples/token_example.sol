pragma solidity ^0.4.0;

import "browser/ERC20.sol";

/* interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf() external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint 256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    
    function Transfer (address indexed from, address indexed to, uint256 value);
    function Approval (address indexed owner, address indexed spender, uint256 value);
    

}
*/

contract Brauncoin is ERC20 {
    constructor (string memory name, string memory symbol) ERC20(name, symbol) public {
        // 1.00 USD = 100 cents = two decimals
        //  1 Ether = 10 ** 18 wei  (18 decimals)
        // _mint (msg.sender, 100 * 10 ** 18 uint(decimals()));
        
        uint __totalSupply = 1000; 
        mapping (address => uint) __balanceOf;
        mapping (address => mapping(address => uint)) _allowances;
        __balanceOf[msg.sender] = __totalSupply;
    } 
    
    function totalSupply () constant returns (uint constant _totalSupply) {
        _totalSupply = __totalSupply;
        return _totalSupply;
    }
    
    function balanceOf(address addr) constant returns (uint balance) {
        return __balanceOf[addr];
    }
    
    function transfer (address _recipient, uint _amount) returns (bool success) {
        if (_amount > 0 && _amount  <= balanceOf(msg.sender)) { 
            __balanceOf(msg.sender) -= _amount;
            _balanceOf[_recipient] += _amount;
            return true;
        }
        return false;
    }
    
    function approve(address _sender, uint _value) returns (bool success) {
        __allowances [msg.sender][_sender] = _value;
        return true;
    }
    
    function transferFrom(address _sender, address _receiver, uint _amount) returns (bool success) {
        if (__allowances[sender][msg.sender] > 0 &&
            _amount > 0 &&
            __allowances[_sender][msg.sender] >= _amount) {
                __balanceOf[_sender -= amount];
                __balanceOf[_recipient] += _amount;
                return true;
        } else {
                return false;
        }
    }
}
