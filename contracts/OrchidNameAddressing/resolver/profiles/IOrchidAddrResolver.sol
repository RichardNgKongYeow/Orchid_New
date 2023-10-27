// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;

interface IOrchidAddrResolver {
    /**
     * @notice Sets the address associated with an ENS node.
     * @param node The ENS node to associate with the address.
     * @param a The address to set.
     */
    function setAddr(bytes32 node, address a) external;

    /**
     * @notice Returns the address associated with an ENS node.
     * @param node The ENS node to query.
     * @return The associated address, or 0x0 if not found.
     */
    function addr(bytes32 node) external view returns (address payable);

    /**
     * @notice Checks if an address is mapped to an ENS node.
     * @param node The ENS node to check.
     * @return True if an address is mapped, false otherwise.
     */
    function isAddressMapped(bytes32 node) external view returns (bool);

    /**
     * @notice Deletes the address mapping for an ENS node.
     * @param node The ENS node to delete the mapping for.
     */
    function deleteAddr(bytes32 node) external;
    
    // Additional functions can be added here if needed to reflect changes in the contract
}
