//SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;

import "@openzeppelin/contracts/utils/introspection/IERC165.sol";

/**
 * This contract reference Ethereum Name Service as base. It implements similar
 * 2-tier structure to achieve name to address mapping.
 */

 interface IOrchidResolver {

    /**
     * @dev Emitted when there is a change in the associated address for a node.
     * @param node The node for which the associated address has been modified.
     * @param a The updated address now associated with the node.
     */
    event AddrChanged(bytes32 indexed node, address a);

    /**
     * @notice Updates the address associated with the specified node to the provided address.
     * @param node The target node for the address update.
     * @param addr The new address to associate with the node.
     * This function can only be invoked by the owner of the node.
     * Emits AddrChanged(bytes32 indexed node, address a) event:
     */
    function setAddr(bytes32 node, address addr) external;

    /**
     * @notice Retrieves the address associated with a specific node.
     * @param node The node to inquire about.
     * @return The corresponding associated address.
     */
    function addr(bytes32 node) external view returns (address payable);

    /**
    * @notice Grants or revokes permission for a delegate to manage the node.
    * @param node The node to which the permission is granted/revoked for a delegate.
    * @param delegate The address of the delegate being granted or revoked permission.
    * @param approved The new approval status (true to grant, false to revoke).
    * @dev This function allows the owner of a node to delegate management 
    *      to the provided delegate address. The delegate can update records for the node
    *      granted permission. Use 'approved' parameter to control the approval status.
    */
   function approve(bytes32 node, address delegate, bool approved) external;

   /**
     * @notice Retrieves a page of nodes and their corresponding addresses from the resolver.
     * @param pageIndex The index of the desired page (0 for all data).
     * @param pageSize The number of items per page (use a large number to fetch all data).
     * @return nodeResult An array of nodes in the requested page.
     * @return addressResult An array of addresses corresponding to the nodes in the requested page.
     */
    function getAllNodesAndAddresses(uint256 pageIndex, uint256 pageSize) external view returns (bytes32[] memory nodeResult, address[] memory addressResult);
 }