// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;    
    
abstract contract OrchidResolverBase{
    address public owner;
    mapping(bytes32 => bool) public records;

    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    modifier nodeExists(bytes32 node) {
        require(records[node], "Node does not exist");
        _;
    }

}

