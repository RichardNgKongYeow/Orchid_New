// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;

interface IOrchidNameResolver {
    /**
     * @notice Sets the name associated with an ENS node, for reverse records.
     * @param node The ENS node to update.
     * @param newName The new name to associate with the node.
     */
    function setName(bytes32 node, string calldata newName) external;

    /**
     * @notice Returns the name associated with an ENS node, for reverse records.
     * @param node The ENS node to query.
     * @return The associated name, or an empty string if not found.
     */
    function name(bytes32 node) external view returns (string memory);

    // You can add additional functions here if needed
}
