// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;

import "../OrchidNameAddressing/registry/OrchidRegistrarController.sol";
import "../OrchidNameAddressing/resolver/profiles/OrchidTextResolver.sol";
import "../OrchidNameAddressing/resolver/OrchidResolver.sol";
import "./profiles/TextConditions.sol";


// Inherit from OrchidRegistrarController
abstract contract PBMConditions is OrchidRegistrarController, OrchidTextResolver, TextConditions {
    OrchidResolver public orchidResolver;

    constructor(
        address _registryAddress,
        address _reverseRegistrarAddress,
        address _controllerOwner,
        address _PBMOwner
    ) OrchidRegistrarController(_registryAddress, _reverseRegistrarAddress, _controllerOwner) {
    }

    // Function to get the node and resolver address for a given address
    function getNodeAndResolver(address addr) public view returns (bytes32 node, address resolver) {
        node = getReverseRecord(addr);
        resolver = getResolverForAddress(addr);
    }

    function checkTextValueConditionFromAddr(address addr, string calldata key) public view returns (bool) {
        (bytes32 node, address _orchidResolverAddress) = getNodeAndResolver(addr);
        orchidResolver = OrchidResolver(_orchidResolverAddress);
        string memory value = orchidResolver.text(node, key);
        if (bytes(value).length == 0) {
            // Key has no value or doesn't exist, return true
            return true;
        } else {
            return isTextConditionMet(key, value);
        }
    }


}
