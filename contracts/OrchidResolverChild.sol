// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;
import "./ICustomENSRegistry.sol"; // Import the ICustomENSRegistry interface

contract OrchidResolverChild {
    address public owner;
    bytes32 public resolverName;
    mapping(bytes32 => bytes) public addresses;
    ICustomENSRegistry public customRegistry; // Declare the customRegistry variable

    event AddressRegistered(bytes32 indexed node, address indexed a);
    event AddressUpdated(bytes32 indexed node, address indexed a);
    event AddressDeleted(bytes32 indexed node);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    constructor(address _owner, bytes32 _resolverName, address customENSRegistry) {
        owner = _owner;
        resolverName = _resolverName;
        customRegistry = ICustomENSRegistry(customENSRegistry); // Initialize the customRegistry address
    }

    function setAddr(bytes32 node, address a) internal onlyOwner {
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

    // function setAddr(bytes32 node, bytes memory a) public onlyOwner {
    //     addresses[node] = a;
    // }

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

    function setAddrAndRecord(bytes32 node, address a) external onlyOwner {
        setAddr(node, a); // Call the setAddr function in OrchidResolver
        customRegistry.setRecord(node, resolverName, address(this)); // Call the setRecord function in CustomENSRegistry
    }

    function delAddrAndRecord(bytes32 node) public {
        delAddr(node); // Call the delAddr function in OrchidResolver
        customRegistry.deleteRecord(node); // Call the setRecord function in CustomENSRegistry
    }

    function updateResolverAndRecord(address otherResolverAddress, bytes32 node, address newAddress) external onlyOwner {
        delAddrAndRecord(node); // Delete the existing address record
        // Create another instance of OrchidResolver (replace with the correct address)
        OrchidResolverChild otherResolver = OrchidResolverChild(otherResolverAddress);
        otherResolver.setAddrAndRecord(node, newAddress); // Call setAddrAndRecord of the other OrchidResolver
    }

}