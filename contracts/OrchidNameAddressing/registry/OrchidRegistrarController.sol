// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;

import "../reverseRegistrar/ReverseRegistrar.sol"; 
import "./OrchidRegistry.sol";
import "../resolver/OrchidResolver.sol";


contract OrchidRegistrarController{
    OrchidRegistry public registry;
    ReverseRegistrar public reverseRegistrar;

    constructor(
        address _registryAddress,
        address _reverseRegistrarAddress
    ) {
        registry = OrchidRegistry(_registryAddress);
        reverseRegistrar = ReverseRegistrar(_reverseRegistrarAddress);

    }


    function _setReverseRecord(bytes32 node, address owner, address resolver) internal {
        reverseRegistrar.setNameForAddr(owner, node);
        reverseRegistrar.setResolverForAddr(owner, resolver);
    }


    function register(bytes32 node, address owner, address resolver, uint64 ttl) public {
        registry.setRecord(node, owner, resolver, ttl);
        _setReverseRecord(node, owner, resolver);

    }

    function getReverseRecord(address addr) public view returns (bytes32) {
        return reverseRegistrar.node(addr);
    }

    function getResolverForAddress(address addr) public view returns (address) {
        return reverseRegistrar.getResolverForAddr(addr);
    }

    // TODO can make this more modularised but having an array of enabled profile types and their functions
    function getTextInfoOfAddr(address addr, string calldata key) public view returns (string memory) {
        bytes32 node = getReverseRecord(addr);
        address resolver = getResolverForAddress(addr);
        OrchidResolver orchidResolver = OrchidResolver(resolver);
        return orchidResolver.text(node,key);
    }


}
