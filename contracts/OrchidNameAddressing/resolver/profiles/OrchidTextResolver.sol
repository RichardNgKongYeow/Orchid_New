// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;

import "../OrchidResolverBase.sol";

abstract contract OrchidTextResolver is OrchidResolverBase {
    mapping(bytes32 => mapping(string => string)) texts;
    //mapping(bytes32 => mapping(string => bool)) keys; // Mapping to track existing keys
    mapping(bytes32 => string[]) textKeys;
    mapping(bytes32 => mapping(string => uint256)) textKeysIndex;

    uint public textCount = 0;
    mapping(uint => string) public allTexts;

    event TextAdded(bytes32 indexed node, string indexed key, string value);
    event TextChanged(bytes32 indexed node, string indexed key, string value);
    event TextDeleted(bytes32 indexed node, string indexed key);
    event KeySet(bytes32 indexed node, string indexed key);

    // /**
    //  * Sets the key associated with an ENS node.
    //  * May only be called by the owner of that node in the ENS registry.
    //  * @param node The node to update.
    //  * @param key The key to set.
    //  */
    // function setKey(
    //     bytes32 node,
    //     string calldata key
    // ) external onlyOwner nodeExists(node) {
    //     require(bytes(key).length > 0, "Key must not be empty");
    //     require(!keys[node][key], "Key already exists");
        
    //     keys[node][key] = true;
    //     emit KeySet(node, key);
    // }

    /**
     * @notice Sets the text data associated with an ENS node and key.
     * @notice May only be called by the owner of that node in the ENS registry.
     * @param node The node to update.
     * @param key The text data key to set.
     * @param value The text data value to set.
     */
    function setText(
        bytes32 node,
        string calldata key,
        string calldata value
    ) external onlyOwner(node) {
        require(bytes(key).length > 0, "Key must not be empty");

        if(bytes(texts[node][key]).length == 0) {
            texts[node][key] = value;
            
            textKeysIndex[node][key] = textKeys[node].length;
            textKeys[node].push(key);

            emit TextAdded(node, key, value);
        } else {
            texts[node][key] = value;
            emit TextChanged(node, key, value);
        }
        
        allTexts[textCount] = value;
        textCount++;
        //records.push(node);

        if(!nodes[node]) {
            nodes[node] = true;
            nodeKeys.push(node);
        }
    }

    /**
     * @notice Returns the text data associated with an ENS node and key.
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

    /** 
     * @notice Deletes the text data associated with an ENS node and key.
     * @notice May only be called by the owner of that node in the ENS registry.
     * @param node The node to update.
     * @param key The text data key to delete.
     */
    function deleteText(
        bytes32 node,
        string calldata key
    ) external onlyOwner(node) {
        require(bytes(key).length > 0, "Key must not be empty");

        delete texts[node][key];
        textKeys[node][textKeysIndex[node][key]] = "";

        emit TextDeleted(node, key);
    }

    function getTextKeysAndValues(bytes32 node) public view returns (string[] memory keys, string[] memory values) {
        uint256 length = textKeys[node].length;
        keys = new string[](length);
        values = new string[](length);

        uint256 validKeyCount = 0;
        for (uint256 i = 0; i < length; i++) {
            if (bytes(textKeys[node][i]).length != 0) {
                keys[validKeyCount] = textKeys[node][i];
                values[validKeyCount] = texts[node][textKeys[node][i]];
                validKeyCount++;
            }
        }

        assembly {
            mstore(keys, validKeyCount)
            mstore(values, validKeyCount)
        }

        return (keys, values);
    }
}
