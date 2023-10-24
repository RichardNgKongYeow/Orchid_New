//SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;


contract OrchidRegistry{
    address contractOwner;

    struct Record {
        address owner;
        address resolver;
        uint64 ttl;
    }
    
    event Transfer(bytes32 indexed node, address owner);
    event NewResolver(bytes32 indexed node, address resolver);
    event ApprovalForAll(address indexed owner,address indexed operator,bool approved);

    mapping(bytes32 => Record) records;
    mapping(address => mapping(address => bool)) operators;
    bytes32[] recordKeys;

    modifier authorised(bytes32 node) {
        address owner = records[node].owner;
        require(owner == msg.sender || operators[owner][msg.sender] ||
            owner == address(0x0) , "Only authorised can call this function");
        _;
    }

    constructor() {
        contractOwner = msg.sender;
    }

    /**
     * @notice Sets the record for a specific node in the registry.
     * @param node The node for which the record is being set.
     * @param owner The address of the new owner for the node.
     * @param resolver The address of the resolver contract for the node.
     * @param ttl The time-to-live (TTL) value for the node's record.
     * This function is used to update the ownership, resolver, and TTL of a node's record.
    */
    function setRecord(
        bytes32 node,
        address owner,
        address resolver,
        uint64 ttl
    ) public authorised(node) {
        setNodeOwner(node, owner);
        setResolver(node, resolver);
    }
    
    function setNodeOwner(bytes32 node, address owner) internal authorised(node){
        if (records[node].owner == address(0x0)) {
            records[node].owner = owner;
            recordKeys.push(node);
        } else {
            records[node].owner = owner;
            emit Transfer(node, owner);
        }
    }

    function setResolver(bytes32 node, address resolver) internal {
        if (resolver != records[node].resolver) {
            records[node].resolver = resolver;
            emit NewResolver(node, resolver);
        }
    }

    function getRecord(bytes32 node) external view returns (address, address) {
        return (records[node].owner, records[node].resolver);
    }

    /**
     * @notice Sets or revokes operator approval for all node of the sender.
     * @param operator The address of the operator whose approval status is changing.
     * @param approved The new approval status (true for approved, false for not approved).
     */
    function setApprovalForAll(address operator, bool approved) external {
        operators[msg.sender][operator] = approved;
        emit ApprovalForAll(msg.sender, operator, approved);
    }

    /**
     * @notice Retrieves the owner address associated with a specific node.
     * @param node The node to inquire about.
     * @return The address of the owner of the node.
     */
    function owner(bytes32 node) external view returns (address) {
        address addr = records[node].owner;
        if (addr == address(this)) {
            return address(0x0);
        }
        return addr;
    }

    /**
     * @notice Retrieves the resolver contract address associated with a specific node.
     * @param node The node to inquire about.
     * @return The address of the resolver contract for the node.
     */
    function resolver(bytes32 node) external view returns (address) {
        return records[node].resolver;
    }

    /**
     * @notice Checks if a record exists for the provided node.
     * @param node The node to inquire about.
     * @return True if a record exists for the node, false otherwise.
     */
    function recordExists(bytes32 node) external view returns (bool) {
        return records[node].owner != address(0x0);
    }

    /**
     * @notice Checks if an operator is approved to manage all tokens of a specific owner.
     * @param owner The address of the token owner.
     * @param operator The address of the operator.
     * @return True if the operator is approved, false otherwise.
     */
    function isApprovedForAll(
        address owner,
        address operator
    ) external view returns (bool) {
        return operators[owner][operator];
    }

    /**
     * @notice Retrieves all nodes and their corresponding resolver contract addresses from the registry.
     * @return nodes An array of nodes
     * @return owners An arry of owners
     * @return resolvers An array of resolver contract addressses corresponding to the nodes.
     */
    function getAllRecords() external view returns (bytes32[] memory nodes, address[] memory owners, address[] memory resolvers)  {
        uint256 length = recordKeys.length;
        nodes = new bytes32[](length);
        owners = new address[](length);
        resolvers = new address[](length);

        uint256 validRecordCount = 0;
        for (uint256 i = 0; i < length; i++) {
            if(true) {
                bytes32 node = recordKeys[i];
                nodes[validRecordCount] = node;
                owners[validRecordCount] = records[node].owner;
                resolvers[validRecordCount] = records[node].resolver;
                validRecordCount++;
            }
        }

        assembly {
            mstore(nodes, validRecordCount)
            mstore(owners, validRecordCount)
            mstore(resolvers, validRecordCount)
        }

        return (nodes, owners, resolvers);
    }

}