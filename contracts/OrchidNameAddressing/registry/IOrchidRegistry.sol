//SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;

/**
 * This contract reference Ethereum Name Service as base. It implements similar
 * 2-tier structure to achieve name to address mapping.
 */

interface IOrchidRegistry {
    
    /**
     * @dev Emitted when the ownership of a node is transferred to a new account.
     * @param node The node for which ownership is being transferred.
     * @param owner The address of the new owner.
     */
    event Transfer(bytes32 indexed node, address owner);

    // Logged when the owner of a node assigns a new owner to a subnode.
    event NewOwner(bytes32 indexed node, bytes32 indexed label, address owner);

    // Logged when the resolver for a node changes.
    /**
     * @dev Emitted when the resolver associated with a node is updated.
     * @param node The node for which the resolver is being changed.
     * @param resolver The address of the new resolver contract.
     */
    event NewResolver(bytes32 indexed node, address resolver);

    /**
     * @dev Emitted when an operator's approval status for all tokens of an owner changes.
     * @param owner The address of the token owner.
     * @param operator The address of the operator whose approval status is changing.
     * @param approved The new approval status (true for approved, false for not approved).
     */
    event ApprovalForAll(
        address indexed owner,
        address indexed operator,
        bool approved
    );

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
    ) external;

    /**
     * @notice Sets the owner address for a specific node.
     * @param node The node for which the owner is being set.
     * @param owner The address of the new owner for the node.
     */
    function setOwner(bytes32 node, address owner) external;

    /**
     * @notice Sets the resolver contract address for a node.
     * @param node The node for which the resolver is being set.
     * @param resolver The address of the new resolver contract for the node.
     */
    function setResolver(bytes32 node, address resolver) external;

    /**
     * @notice Sets or revokes operator approval for all tokens of the sender.
     * @param operator The address of the operator whose approval status is changing.
     * @param approved The new approval status (true for approved, false for not approved).
     */
    function setApprovalForAll(address operator, bool approved) external;

    /**
     * @notice Retrieves the owner address associated with a specific node.
     * @param node The node to inquire about.
     * @return The address of the owner of the node.
     */
    function owner(bytes32 node) external view returns (address);

    /**
     * @notice Retrieves the resolver contract address associated with a specific node.
     * @param node The node to inquire about.
     * @return The address of the resolver contract for the node.
     */
    function resolver(bytes32 node) external view returns (address);

    /**
     * @notice Checks if a record exists for the provided node.
     * @param node The node to inquire about.
     * @return True if a record exists for the node, false otherwise.
     */
    function recordExists(bytes32 node) external view returns (bool);

    /**
     * @notice Checks if an operator is approved to manage all tokens of a specific owner.
     * @param owner The address of the token owner.
     * @param operator The address of the operator.
     * @return True if the operator is approved, false otherwise.
     */
    function isApprovedForAll(
        address owner,
        address operator
    ) external view returns (bool);

    /**
     * @notice Retrieves all the resolver contract address in the registry.
     * @return The address of all the resolver contracts in the registry.
     */
    function getAllResolvers() external view returns (address[] memory);

    /**
     * @notice Retrieves all nodes and their corresponding resolver contract addresses from the registry.
     * @return nodeResult An array of nodes in the requested page.
     * @return resolverResult An array of resolver contract addressses corresponding to the nodes in the requested page.
     */
    function getAllNodesAndResolvers() external view returns (bytes32[] memory nodeResult, address[] memory resolverResult);

    /**
     * @notice Register a name, or change the owner of an existing registration.
     * @param label The hash of the label to register.
     * @param owner The address of the new owner.
     */
    function register(bytes32 label, address owner) external returns (bytes32);
}