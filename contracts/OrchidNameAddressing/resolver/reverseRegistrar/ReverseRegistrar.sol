// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;

import "../OrchidResolverBase.sol";
// import "../profiles/OrchidAddrResolver.sol";
import "./IReverseRegistrar.sol"; // Import the interface here

abstract contract ReverseRegistrar is OrchidResolverBase {
    mapping(bytes => bytes32) public addrToNames;
    uint public addrToNamesCount = 0;

    event ReverseRecordSet(address indexed a, bytes32 indexed node);
    event ReverseRecordChanged(address indexed a, bytes32 indexed node);

    function setNameForAddr(address a, bytes32 node) public onlyOwner(node) {
        bytes memory aBytes = OrchidResolverBase.addressToBytes(a);

        if (addrToNames[aBytes].length == 0) {
            addrToNames[aBytes] = node;
            addrToNamesCount++;
            emit ReverseRecordSet(a, node);
        } else {
            addrToNames[aBytes] = node;
            emit ReverseRecordChanged(a, node);
        }
    }

    function node(address a) public view returns (bytes32 node) {
        bytes memory aBytes = OrchidResolverBase.addressToBytes(a);
        return addrToNames[aBytes];
    }



    function supportsInterface(
        bytes4 interfaceID
    ) public view virtual override returns (bool) {
        return
            interfaceID == type(IReverseRegistrar).interfaceId ||
            super.supportsInterface(interfaceID);
    }
}
