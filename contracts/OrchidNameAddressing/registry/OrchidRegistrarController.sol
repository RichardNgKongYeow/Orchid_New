// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;

import "../reverseRegistrar/ReverseRegistrar.sol"; 
import "./OrchidRegistry.sol";


contract OrchidRegistrarController{
    OrchidRegistry public registry;
    ReverseRegistrar public reverseRegistrar;
    address public controllerOwner;

    constructor(
        address _registryAddress,
        address _reverseRegistrarAddress,
        address _controllerOwner
    ) {
        registry = OrchidRegistry(_registryAddress);
        reverseRegistrar = ReverseRegistrar(_reverseRegistrarAddress);
        controllerOwner = _controllerOwner;
    }

    modifier onlyControllerOwner() {
        require(msg.sender == controllerOwner, "Only the PBM owner can call this function");
        _;
    }

    function _setReverseRecord(bytes32 node, address resolver, address a) internal {
        reverseRegistrar.setNameForAddr(a, node);
        reverseRegistrar.setResolverForAddr(a, resolver);
    }

    function register(bytes32 node, address owner, address resolver, uint64 ttl, address a) public onlyControllerOwner {
        registry.setRecord(node, owner, resolver, ttl);
        _setReverseRecord(node, resolver, a);
    }

    function getReverseRecord(address addr) public view returns (bytes32) {
        return reverseRegistrar.node(addr);
    }

    function getResolverForAddress(address addr) public view returns (address) {
        return reverseRegistrar.getResolverForAddr(addr);
    }
}
