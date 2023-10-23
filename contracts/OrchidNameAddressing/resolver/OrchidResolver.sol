// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;

import "../registry/OrchidRegistry.sol";
import "./profiles/OrchidAddrResolver.sol";
import "./profiles/OrchidTextResolver.sol";
import "./profiles/OrchidNameResolver.sol";
import "./Multicallable.sol";

contract OrchidResolver is
    Multicallable,
    OrchidAddrResolver, 
    OrchidTextResolver,
    OrchidNameResolver {

    OrchidRegistry registry;

    struct Record {
        string merchantName;
        address addr;
        string[] additionalFieldsKeys;
        string[] additionalFieldsValues;
    }
    uint public dataCount = 0;

    event RegistryRecordSet(bytes32 indexed node, address indexed resolver, address indexed owner);
    event RegistryRecordDeleted(bytes32 indexed node, address indexed resolver);
    event RegistryRecordUpdated(bytes32 indexed node, address indexed resolver, address indexed newOwner);

    
    constructor(address _contractOwner, address _registry) {
        contractOwner = _contractOwner;
        registry = OrchidRegistry(_registry);
    }

    function setAddrAndName(bytes32 node, address a, string calldata name) external onlyNodeOwner(node) {
        bytes32 ZERO_HASH = 0x0000000000000000000000000000000000000000000000000000000000000000;
        bytes32 node2 = keccak256(abi.encodePacked(ZERO_HASH,keccak256(bytes(name))));
        require(node == node2, "Node and namehash.hash(name) is not the same");

        setAddr(node, a);
        setName(node, name);
    }
    
    function getAllRecords() external view returns (Record[] memory records) {
        uint length = nodeKeys.length;
        records = new Record[](length);

        for (uint i = 0; i < length; i++) {
            if (nodes[nodeKeys[i]]) {
                string[] memory keys;
                string[] memory values;

                (keys, values) = getTextKeysAndValues(nodeKeys[i]);

                records[i] = Record({
                    merchantName: name(nodeKeys[i]),
                    addr: addr(nodeKeys[i]),
                    additionalFieldsKeys: keys,
                    additionalFieldsValues: values
                });
            }

        }

        assembly {
            mstore(records, length)
        }

            return records;
        }

    function supportsInterface(
        bytes4 interfaceID
    )
        public
        view
        override(
            Multicallable,
            OrchidAddrResolver,
            OrchidTextResolver,
            OrchidNameResolver
        )
        returns (bool)
    {
        return super.supportsInterface(interfaceID);
    }
}