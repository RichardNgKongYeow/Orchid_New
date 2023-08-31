// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;
import "./ICustomENSRegistry.sol"; // Import the ICustomENSRegistry interface
import "./profiles/OrchidAddrResolver.sol"; // Import the OrchidAddrResolver
import "./profiles/OrchidTextResolver.sol"; // Import the OrchidAddrResolver

contract OrchidResolverChild is 
    OrchidAddrResolver, 
    OrchidTextResolver 

{

    bytes32 public resolverName;
    ICustomENSRegistry public customRegistry; // Declare the customRegistry variable

    event RegistryRecordSet(bytes32 indexed node, address indexed resolver, address indexed owner);
    event RegistryRecordDeleted(bytes32 indexed node, address indexed resolver);
    event RegistryRecordUpdated(bytes32 indexed node, address indexed resolver, address indexed newOwner);

    constructor(address _owner, bytes32 _resolverName, address customENSRegistry) {
        owner = _owner;
        resolverName = _resolverName;
        customRegistry = ICustomENSRegistry(customENSRegistry); // Initialize the customRegistry address
    }

    function setRegistryRecord(bytes32 node) external onlyOwner {
        customRegistry.setRecord(node, resolverName, address(this)); // Call the setRecord function in CustomENSRegistry
        records[node] = true; // Mark the record as set
        emit RegistryRecordSet(node, address(this), owner); // Emit the event for record set
    }

    function delRegistryRecord(bytes32 node) public onlyOwner nodeExists(node) {
        customRegistry.deleteRecord(node); // Call the setRecord function in CustomENSRegistry
        delete records[node]; // Clear the record status
        emit RegistryRecordDeleted(node, address(this)); // Emit the event for record deletion
    }

    function updateRegistryRecord(address otherResolverAddress, bytes32 node) external onlyOwner {
        delRegistryRecord(node); // Delete the existing address record
        // Create another instance of OrchidResolver (replace with the correct address)
        OrchidResolverChild otherResolver = OrchidResolverChild(otherResolverAddress);
        otherResolver.setRegistryRecord(node); // Call setRegistryRecord of the other OrchidResolver
        emit RegistryRecordUpdated(node, address(this), otherResolver.owner()); // Emit the event for record update
    }
}
