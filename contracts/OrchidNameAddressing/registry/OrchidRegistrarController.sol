// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;

import "../reverseRegistrar/ReverseRegistrar.sol"; 
import "./OrchidRegistry.sol";
import "../resolver/OrchidResolverBase.sol";


contract OrchidRegistrarController is OrchidResolverBase{
    OrchidRegistry public registry;
    ReverseRegistrar public reverseRegistrar;
    address public controllerOwner;

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
        nodeOwners[node] = owner;
    }

    function getReverseRecord(address addr) public view returns (bytes32) {
        return reverseRegistrar.node(addr);
    }

    function getResolverForAddress(address addr) public view returns (address) {
        return reverseRegistrar.getResolverForAddr(addr);
    }
}
