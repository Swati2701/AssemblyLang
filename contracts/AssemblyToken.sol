// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;



contract AssemblyToken {
  
  uint256 totalSupply_;
  mapping(address => uint256) public balances;
  event balanceOwner(uint256 supply);
  
  constructor(uint256 _initialSupply) {
    // uint256 hash;
    assembly{
     let totalSupply1_ := _initialSupply
     sstore(0, totalSupply1_)
     mstore(0x80, totalSupply1_)

     //store mapping with assembly lang.
     mstore(0, caller()) //store owner address at 0 location
     mstore(32, balances.slot) 
     let ahsh:= keccak256(0,64) //calculate hash of mapping name
     sstore(ahsh, totalSupply1_)  //store value at hash position.
    //  hash := sload(ahsh)
    //  sstore(1, hash)
    //  mstore(0x82, hash)
    } 
  }

  function totalSupply() public view returns (uint256) {
    return totalSupply_;
  }

  function totalSupplyAssembly() public view returns(uint256){
    assembly{
      let v:= sload(0)
      mstore(0x80, v)
      return(0x80, 256)
    }
  }

  

  function balanceAssembly(address _owner, uint256 _value) external {
    bytes32 hashVal = bytes32(keccak256("balanceOwner(uint256)"));
    assembly{
      mstore(0, _owner)
      mstore(32, balances.slot)
      let hashValue := keccak256(0,64)
      sstore(hashValue, _value)
      log1(0x82, 32, hashVal)
      // let v := sload(1)
      // mstore(0x82, v)
      // return(0x82, 256)
    }
  }

  function transfer(address _to, uint256 _value) public returns (bool) {
    require(_to != address(0));
    require(_value <= balances[msg.sender]);
    balances[msg.sender] = balances[msg.sender] - _value;
    balances[_to] = balances[_to] + _value;
    return true;
  }

  function balanceOf(address _owner) public view returns (uint256) {
    return balances[_owner];
  }
}