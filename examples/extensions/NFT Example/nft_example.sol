// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.4.0-solc-0.7/contracts/token/ERC721/ERC721.sol";


contract NFTExample is ERC721 {
    uint256 public tokenCounter;
    constructor (string memory _name,string memory _symbol) ERC721(_name,_symbol) {}
    
/* Mapping from token ID to owner
   This mapping is needed to store a token against its owner. 
   By using this we can know who is the owner for given tokenId.
*/

  mapping (uint256 => address) private _tokenOwner;
  
 /* Mapping from token ID to approved address
    This mapping is needed to store tokenId, 
    against an address which is approved by the token owner, 
    to transfer a token on behalf of the owner.
 */
 
  mapping (uint256 => address) private _tokenApprovals;
 
 /* Mapping from owner to number of owned token
 This mapping is needed to know how many tokens an address owns. 
 If we don’t create this mapping,
 we have to loop to get this information and looping takes lots of gas on EVM.
 */
 
  mapping (address => uint256) private _ownedTokensCount;
  
  /* Mapping from owner to operator approvals
  Mapping of an owner and an operator 
  (any address, mostly wallets, and exchanges) to check 
   if the owner had given approval or not.
  */
  
  mapping (address => mapping (address => bool)) private _operatorApprovals;
  
  /* balanceOf() 
     This will return the balance of an address.
     First, it checks for a valid address and then 
     using _ownedTokensCount returns the count of the token.
  */
  
  function balanceOf(address owner) public view override returns (uint256) {
    require(owner != address(0));
    return _ownedTokensCount[owner];
  }
  
  /* ownerOf() 
     This will return the owner address 
     for a given token using _tokenOwner mapping.
  */
  
  function ownerOf(uint256 tokenId) public view override returns (address) {
    address owner = _tokenOwner[tokenId];
    require(owner != address(0));
    return owner;
  }
  
  /* approve() 
     This will approve an address to transfer a token on behalf of the owner. 
     The function first checks if the owner called the function or if the call 
     is approved by the owner to send all tokens.
     Then it updates the _tokenApprovals mapping if everything is correct.
  */
  
  function approve(address to, uint256 tokenId) public override {
    address owner = ownerOf(tokenId);
    require(to != owner);
    require(msg.sender == owner || isApprovedForAll(owner, msg.sender));_tokenApprovals[tokenId] = to;
    emit Approval(owner, to, tokenId);
  }
  
  /* safeTransferFrom()
   There are two functions with similar names, but with different arguments. 
   These functions internally call transferFrom function.
   Though they also perform one more important duty. 
   They check if the recipient address is valid for receiving the token or not.
   This helps in the security of the token.
 */
 function safeTransferFrom(
    address from,
    address to,
    uint256 tokenId,
    bytes _data
  )
    public
  {
    transferFrom(from, to, tokenId);
  }
 
 /* transferFrom()
    This is the main function to transfer a token from one address to another address.
    1- Check if the token is either owned by called or approved to the caller. Also, checks of a valid address.
    2- Clear approval, remove current ownership and reduce the token count of the current owner.
    3- Add token to recipient account and increase the token count for the recipient.
 */
 
 function transferFrom(
    address from,
    address to,
    uint256 tokenId
  )
    public
  {
    require(_isApprovedOrOwner(msg.sender, tokenId));
    require(to != address(0));
    clearApprovalAndTransfer(msg.sender, to, tokenId);
  }
  
 /* setApprovalForAll() 
  This function approves the address to transfer all tokens on behalf of the owner. 
  It first checks if the called and to address are not the same, 
  and then updates the _operatorApprovals mapping. 
  */
  
  function setApprovalForAll(address to, bool approved) public {
    require(to != msg.sender);
    _operatorApprovals[msg.sender][to] = approved;
    emit ApprovalForAll(msg.sender, to, approved);
  }
  
  /* isApprovedForAll() 
     This function checks if the owner approved the 
     operator to transfer tokens or not.
  */
  
  function isApprovedForAll(
    address owner,
    address operator
  )
    public
    view
    returns (bool)
  {
    return _operatorApprovals[owner][operator];
  }
  
  /* getApproved() 
     Returns the approved address for given tokenId.
  */
  
  function getApproved(uint256 tokenId) public view returns (address) {
    require(_exists(tokenId));
    return _tokenApprovals[tokenId];
  }   
  
}