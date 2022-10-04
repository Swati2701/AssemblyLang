pragma solidity ^0.8.2;

import "hardhat/console.sol";

contract StoreData{

    // event SetData(uint256 newValue);

    function setData(uint256 value) external returns (uint256){
        assembly{
            sstore(0, value)
            let num := sload(0)
            mstore(0x80, num)
            return(0x80, 32)
        }

        // emit SetData(value);
    }


    function getData() external view returns(uint256){
        // uint256 newValue;
        assembly{
            let v := sload(0)
            // newValue := v
            mstore(0x80, v)
            return(0x80, 32)
        }
        // console.log("New value is",newValue);
    }
}