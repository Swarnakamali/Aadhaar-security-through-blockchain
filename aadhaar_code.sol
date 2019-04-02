pragma solidity ^0.4.23;

contract aadhaar_code
{
 string public ipfs_hash;
 
 function sendHash(string memory h) public 
 {
    ipfs_hash = h;
 }
  
 function getHash() public view returns(string memory h)
 {
  return ipfs_hash;
 }
}

