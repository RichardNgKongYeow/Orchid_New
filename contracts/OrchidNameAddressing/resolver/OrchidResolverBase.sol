// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;
import "hardhat/console.sol";
import "./IOrchidResolverBase.sol";
import "../registry/OrchidRegistry.sol"; // Import OrchidRegistry contract

abstract contract OrchidResolverBase is IOrchidResolverBase {
    address contractOwner;
    bytes32[] nodeKeys;
    mapping(bytes32 => bool) nodes;
    mapping(bytes32 => address) nodeOwners; // Mapping to store node owners
    

    event Transfer(address owner);


    function isNodeOwner(bytes32 node) internal view virtual returns (bool) {
        address owner = nodeOwners[node]; // Check the local mapping for the owner
        return owner == msg.sender;
    }

    modifier authorised(bytes32 node) {
        require(isNodeOwner(node) || msg.sender == contractOwner 
        || tx.origin == nodeOwners[node] 
        || nodeOwners[node] == address(0x0), "Only authorised can call this resolver function");
        _;
    }

    function setOwner(address _contractOwner) public {
        require(msg.sender == contractOwner, "Only owner can call this function");
        contractOwner = _contractOwner;
        emit Transfer(contractOwner);
    }

    function supportsInterface(bytes4 interfaceID) public view virtual override returns (bool) {
        return
            interfaceID == type(IOrchidResolverBase).interfaceId ||
            supportsInterface(interfaceID);
    }
}
