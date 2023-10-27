// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;

interface IOrchidTextResolver {
    /**
     * @notice Sets the text data associated with an ENS node and key.
     * @param node The ENS node to update.
     * @param key The text data key to set.
     * @param value The text data value to set.
     */
    function setText(bytes32 node, string calldata key, string calldata value) external;

    /**
     * @notice Returns the text data associated with an ENS node and key.
     * @param node The ENS node to query.
     * @param key The text data key to query.
     * @return The associated text data.
     */
    function text(bytes32 node, string calldata key) external view returns (string memory);

    /** 
     * @notice Deletes the text data associated with an ENS node and key.
     * @param node The ENS node to update.
     * @param key The text data key to delete.
     */
    function deleteText(bytes32 node, string calldata key) external;

    /**
     * @notice Retrieves all text data keys and values associated with an ENS node.
     * @param node The ENS node to query.
     * @return keys An array of text data keys.
     * @return values An array of text data values corresponding to the keys.
     */
    function getTextKeysAndValues(bytes32 node) external view returns (string[] memory keys, string[] memory values);

    // Additional functions can be added here if needed to reflect changes in the contract
}
