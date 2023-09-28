// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;

import "../registry/OrchidRegistry.sol";
import "./profiles/OrchidAddrResolver.sol";
import "./profiles/OrchidTextResolver.sol";
import "./profiles/OrchidNameResolver.sol";
import "./Multicallable.sol";
import "./reverseRegistrar/ReverseRegistrar.sol";

contract OrchidResolver is
    Multicallable,
    ReverseRegistrar,
    OrchidAddrResolver, 
    OrchidTextResolver,
    OrchidNameResolver {

    OrchidRegistry registry;

    struct AllData {
        string name;
        address nodeAddress;
    }
    uint public dataCount = 0;
    mapping (uint => AllData) public allDatas;

    event RegistryRecordSet(bytes32 indexed node, address indexed resolver, address indexed owner);
    event RegistryRecordDeleted(bytes32 indexed node, address indexed resolver);
    event RegistryRecordUpdated(bytes32 indexed node, address indexed resolver, address indexed newOwner);

    function isOwner(bytes32 node) internal view override returns (bool) {
        address nodeOwner = registry.owner(node);
        return msg.sender == contractOwner || msg.sender == nodeOwner;
    }
    
    constructor(address _contractOwner, address _registry) {
        contractOwner = _contractOwner;
        registry = OrchidRegistry(_registry);
    }

    function setAddrAndName(bytes32 node, address a, string calldata name) external onlyOwner(node) {
        bytes32 ZERO_HASH = 0x0000000000000000000000000000000000000000000000000000000000000000;
        bytes32 node2 = keccak256(abi.encodePacked(ZERO_HASH,keccak256(bytes(name))));
        require(node == node2, "Node and namehash.hash(name) is not the same");

        setAddr(node, a);
        setName(node, name);
    }
    
    function getAllRecords() external view returns(string[] memory resolverNames, address[] memory resolverAddresses, string[] memory resolverTexts) {
        //uint count = OrchidAddrResolver.addressCount;
        uint length = nodeKeys.length;
        resolverNames = new string[](length);
        //resolverNodes = new bytes32[](count);
        resolverAddresses = new address[](length);
        resolverTexts = new string[](length);
        // AllData[] memory id = new AllData[](count);
        for (uint i = 0; i < length; i++) {
            //resolverNames[i] = OrchidNameResolver.allNames[i];
            if(nodes[nodeKeys[i]]) {
                //resolverNodes[i] = OrchidNameResolver.nodes[i];
                resolverNames[i] = this.name(nodeKeys[i]);
                resolverAddresses[i] = this.addr(nodeKeys[i]);
                resolverTexts[i] = this.text(nodeKeys[i],"MCC");
            }
        }

        assembly {
            mstore(resolverNames, length)
            //mstore(resolverNodes, count)
            mstore(resolverAddresses, length)
            mstore(resolverTexts, length)
        }

        return (resolverNames, resolverAddresses, resolverTexts);
    }

    function supportsInterface(
        bytes4 interfaceID
    )
        public
        view
        override(
            ReverseRegistrar,
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