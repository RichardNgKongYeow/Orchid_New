// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;

import "./IReverseRegistrar.sol"; // Import the interface here
import "../root/Controllable.sol";

contract ReverseRegistrar is Controllable{
    address orchidRegistry;
    mapping(bytes => bytes32) public addrToNames;
    uint public addrToNamesCount = 0;
    mapping(bytes => address) public addrToResolver; // New mapping to store resolver addresses

    event ReverseRecordSet(address indexed a, bytes32 indexed node);
    event ReverseRecordChanged(address indexed a, bytes32 indexed node);

    constructor(address _orchidRegistry) {
        orchidRegistry = _orchidRegistry;
    }

    modifier authorised(address addr) {
        require( addr == msg.sender || controllers[msg.sender], 
            "ReverseRegistrar: Caller is not a controller or authorised by address or the address itself"
        );
        _;
    }

    function setNameForAddr(address a, bytes32 node) external authorised(a) {
        bytes memory aBytes = addressToBytes(a);

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
        bytes memory aBytes = addressToBytes(a);
        return addrToNames[aBytes];
    }

    function setResolverForAddr(address a, address resolver) external authorised(a) {
        bytes memory aBytes = addressToBytes(a);
        addrToResolver[aBytes] = resolver;
    }

    function getResolverForAddr(address a) external view returns (address) {
        bytes memory aBytes = addressToBytes(a);
        return addrToResolver[aBytes];
    }

    function addressToBytes(address a) internal pure returns (bytes memory b) {
        b = new bytes(20);
        assembly {
            mstore(add(b, 32), mul(a, exp(256, 12)))
        }
    }


}
