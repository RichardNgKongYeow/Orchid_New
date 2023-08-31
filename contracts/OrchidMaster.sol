// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;
import "./ICustomENSRegistry.sol"; // Import the ICustomENSRegistry interface

contract OrchidMaster {
    address public orchidMasterOwner;  // Owner of the OrchidMaster contract
    
    struct ResolverInfo {
        address resolverAddress;
        bytes32 resolverName;
        address owner;
    }

    ResolverInfo[] public resolverList;
    mapping(bytes32 => uint256) public resolverNameToIndex;

    event ResolverCreated(address indexed resolverAddress, bytes32 indexed resolverName, address indexed owner);

    constructor(address _orchidMasterOwner) {
        orchidMasterOwner = _orchidMasterOwner;  // Set the owner of the OrchidMaster contract
    }

    modifier onlyOwner() {
        require(msg.sender == orchidMasterOwner, "Only OrchidMaster owner can call this function");
        _;
    }

    function createResolver(address _owner, bytes32 _resolverName, address _customENSRegistry) external onlyOwner {
        OrchidResolver newResolver = new OrchidResolver(_owner, _resolverName, _customENSRegistry);
        resolverList.push(ResolverInfo(address(newResolver), _resolverName, _owner));
        resolverNameToIndex[_resolverName] = resolverList.length - 1; // Store the index of the new resolver
        emit ResolverCreated(address(newResolver), _resolverName, _owner);
    }

    function getResolverInfo(uint256 index) external view returns (ResolverInfo memory) {
        require(index < resolverList.length, "Index out of bounds");
        return resolverList[index];
    }

    function getResolverInfoByName(bytes32 _resolverName) external view returns (ResolverInfo memory) {
        uint256 index = resolverNameToIndex[_resolverName];
        require(index < resolverList.length, "Resolver not found");
        return resolverList[index];
    }

    function getResolverCount() external view returns (uint256) {
        return resolverList.length;
    }
}


import "./ICustomENSRegistry.sol"; // Import the ICustomENSRegistry interface
import "./profiles/OrchidAddrResolver.sol"; // Import the OrchidAddrResolver
import "./profiles/OrchidTextResolver.sol"; // Import the OrchidAddrResolver

contract OrchidResolver is 
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
        OrchidResolver otherResolver = OrchidResolver(otherResolverAddress);
        otherResolver.setRegistryRecord(node); // Call setRegistryRecord of the other OrchidResolver
        emit RegistryRecordUpdated(node, address(this), otherResolver.owner()); // Emit the event for record update
    }
}
