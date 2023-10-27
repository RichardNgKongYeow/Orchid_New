// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;

interface IReverseRegistrar {
    /**
     * @notice Sets the name associated with an address for reverse records.
     * @param a The address to update.
     * @param node The ENS node to associate with the address.
     */
    function setNameForAddr(address a, bytes32 node) external;

    /**
     * @notice Returns the ENS node associated with an address for reverse records.
     * @param a The address to query.
     * @return The associated ENS node.
     */
    function node(address a) external view returns (bytes32);
}
