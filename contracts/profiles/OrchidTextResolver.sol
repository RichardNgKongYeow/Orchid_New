// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;

import "../name_addressing/OrchidResolverBase.sol";

abstract contract OrchidTextResolver is OrchidResolverBase {
    mapping(bytes32 => mapping(string => string)) public texts;
    mapping(bytes32 => mapping(string => bool)) public keys; // Mapping to track existing keys

    event TextRegistered(bytes32 indexed node, string indexed key, string value);
    event TextChanged(bytes32 indexed node, string indexed key, string value);
    event TextDeleted(bytes32 indexed node, string indexed key);
    event KeySet(bytes32 indexed node, string indexed key);

    /*
     * Sets the key associated with an ENS node.
     * May only be called by the owner of that node in the ENS registry.
     * @param node The node to update.
     * @param key The key to set.
     */
    function setKey(
        bytes32 node,
        string calldata key
    ) external onlyOwner nodeExists(node) {
        require(bytes(key).length > 0, "Key must not be empty");
        require(!keys[node][key], "Key already exists");
        
        keys[node][key] = true;
        emit KeySet(node, key);
    }

    /*
     * Sets the text data associated with an ENS node and key.
     * May only be called by the owner of that node in the ENS registry.
     * @param node The node to update.
     * @param key The text data key to set.
     * @param value The text data value to set.
     */
    function setText(
        bytes32 node,
        string calldata key,
        string calldata value
    ) external onlyOwner nodeExists(node) {
        require(bytes(key).length > 0, "Key must not be empty");
        
        texts[node][key] = value;
        
        if (bytes(value).length == 0) {
            emit TextRegistered(node, key, value);
        } else {
            emit TextChanged(node, key, value);
        }
    }

    /*
     * Returns the text data associated with an ENS node and key.
     * @param node The ENS node to query.
     * @param key The text data key to query.
     * @return The associated text data.
     */
    function text(
        bytes32 node,
        string calldata key
    ) external view returns (string memory) {
        return texts[node][key];
    }

    /*
     * Deletes the text data associated with an ENS node and key.
     * May only be called by the owner of that node in the ENS registry.
     * @param node The node to update.
     * @param key The text data key to delete.
     */
    function delText(
        bytes32 node,
        string calldata key
    ) external onlyOwner nodeExists(node) {
        require(bytes(key).length > 0, "Key must not be empty");

        delete texts[node][key];

        emit TextDeleted(node, key);
    }
}
