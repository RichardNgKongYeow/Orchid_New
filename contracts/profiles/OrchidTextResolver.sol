// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;

import "../OrchidResolverBase.sol";

abstract contract OrchidTextResolver is OrchidResolverBase {
    mapping(bytes32 => string) public texts;

    event TextRegistered(bytes32 indexed node, string indexed value);
    event TextChanged(bytes32 indexed node, string indexed value);
    event TextDeleted(bytes32 indexed node);


    /*
     * Sets the text data associated with an ENS node and key.
     * May only be called by the owner of that node in the ENS registry.
     * @param node The node to update.
     * @param value The text data value to set.
     */
    function setText(
        bytes32 node,
        string calldata value
    ) external onlyOwner nodeExists(node) {
        bytes memory valueBytes = bytes(value);
        if (valueBytes.length == 0) {
            texts[node] = value;
            emit TextRegistered(node, value);
        } else {
            texts[node] = value;
            emit TextChanged(node, value);
        }

    }

    /*
     * Returns the text data associated with an ENS node and key.
     * @param node The ENS node to query.
     * @param key The text data key to query.
     * @return The associated text data.
     */
    function text(
        bytes32 node
    ) external view returns (string memory) {
        return texts[node];
    }


}
