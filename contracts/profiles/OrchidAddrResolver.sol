// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;
import "../OrchidResolverBase.sol"; // Import the ICustomENSRegistry interface

abstract contract OrchidAddrResolver is OrchidResolverBase{
    mapping(bytes32 => bytes) public addresses;

    event AddressRegistered(bytes32 indexed node, address indexed a);
    event AddressUpdated(bytes32 indexed node, address indexed a);
    event AddressDeleted(bytes32 indexed node);

    function setAddr(bytes32 node, address a) internal onlyOwner nodeExists(node){
        bytes memory aBytes = addressToBytes(a);
        if (addresses[node].length == 0) {
            addresses[node] = aBytes;
            emit AddressRegistered(node, a);
        } else {
            addresses[node] = aBytes;
            emit AddressUpdated(node, a);
        }
    }

    function addr(bytes32 node) public view returns (address payable) {
        bytes memory a = addresses[node];
        if (a.length == 0) {
            return payable(0);
        }
        return bytesToAddress(a);
    }


    function bytesToAddress(bytes memory b) internal pure returns (address payable a) {
        require(b.length == 20);
        assembly {
            a := div(mload(add(b, 32)), exp(256, 12))
        }
    }

    function addressToBytes(address a) internal pure returns (bytes memory b) {
        b = new bytes(20);
        assembly {
            mstore(add(b, 32), mul(a, exp(256, 12)))
        }
    }

    function isAddressMapped(bytes32 hash) public view returns (bool) {
        return addresses[hash].length > 0;
    }

    function delAddr(bytes32 node) public onlyOwner {
        if (addresses[node].length == 0) {
            revert("No record found");
        }
        delete addresses[node];
        emit AddressDeleted(node);
    }

}