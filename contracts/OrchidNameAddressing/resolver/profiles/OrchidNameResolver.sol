// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;
import "../OrchidResolverBase.sol";

abstract contract OrchidNameResolver is OrchidResolverBase {
    mapping(bytes32 => string) names;

    uint public nameCount = 0;
    mapping(uint => string) public allNames;
    //mapping(uint => bytes32) public nodes;

    event NameChanged(bytes32 indexed node, string name);

    /**
     * Sets the name associated with an ENS node, for reverse records.
     * May only be called by the owner of that node in the ENS registry.
     * @param node The node to update.
     */
    function setName(
        bytes32 node,
        string calldata newName
    ) public onlyOwner(node) {
        names[node] = newName;
        // allNames[nameCount] = newName;
        // nodes[nameCount] = node;
        // nameCount++;
        emit NameChanged(node, newName);

        if(!nodes[node]) {
            nodes[node] = true;
            nodeKeys.push(node);
        }
    }

    /**
     * Returns the name associated with an ENS node, for reverse records.
     * Defined in EIP181.
     * @param node The ENS node to query.
     * @return The associated name.
     */
    function name(
        bytes32 node
    ) external view returns (string memory) {
        return names[node];
    }
}