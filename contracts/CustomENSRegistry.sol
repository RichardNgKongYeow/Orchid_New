// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;

interface IOrchidResolver {
    function isAddressMapped(bytes32 hash) external view returns (bool);
}

contract CustomENSRegistry {
    address public owner;
    
    struct Record {
        bytes32 resolverName;
        address resolver;
    }
    
    mapping(bytes32 => Record) public records;

    event RecordCreated(bytes32 indexed node, bytes32 resolverName, address resolver);
    event RecordDeleted(bytes32 indexed node);
    event ResolverUpdated(bytes32 indexed node, address newResolver);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    constructor(address _owner) {
        owner = _owner;
    }

    function setRecord(bytes32 node, bytes32 resolverName, address resolver) external {
        require(node != bytes32(0), "Invalid node");
        require(isAuthorizedResolver(node, resolver), "Unauthorized resolver");
        require(records[node].resolver == address(0), "Node already registered");

        records[node] = Record(resolverName, resolver);
        emit RecordCreated(node, resolverName, resolver);
    }

    function getRecord(bytes32 node) external view returns (bytes32, address) {
        Record storage record = records[node];
        return (record.resolverName, record.resolver);
    }

    function deleteRecord(bytes32 node) external {
        Record storage record = records[node];
        require(record.resolver != address(0), "Record does not exist");
        require(msg.sender == record.resolver || msg.sender == owner, "Not authorized");

        delete records[node];
        emit RecordDeleted(node);
    }

    function updateResolver(bytes32 node, address newResolver) external {
        Record storage record = records[node];
        require(record.resolver != address(0), "Record does not exist");
        require(msg.sender == record.resolver || msg.sender == owner, "Not authorized");

        record.resolver = newResolver;
        emit ResolverUpdated(node, newResolver);
    }

    function isRecordExist(bytes32 node) external view returns (bool) {
        return records[node].resolver != address(0);
    }

    function getResolverAddress(bytes32 node) external view returns (address) {
        return records[node].resolver;
    }

    function getResolverName(bytes32 node) external view returns (bytes32) {
        return records[node].resolverName;
    }

    function isAuthorizedResolver(bytes32 node, address resolver) internal view returns (bool) {
        return IOrchidResolver(resolver).isAddressMapped(node);
    }
}


