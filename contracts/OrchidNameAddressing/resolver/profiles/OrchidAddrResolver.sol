// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;
import "../OrchidResolverBase.sol";
import "./IOrchidAddrResolver.sol";

abstract contract OrchidAddrResolver is OrchidResolverBase, IOrchidAddrResolver{
    mapping(bytes32 => bytes) addresses;

    uint public addressCount = 0;
    mapping(uint => address) allAddress;
    address[] addressKeys;

    event AddressRegistered(bytes32 indexed node, address indexed a);
    event AddrChanged(bytes32 indexed node, address indexed a);
    event AddressDeleted(bytes32 indexed node);

    function setAddr(bytes32 node, address a) public authorised(node) {
        bytes memory aBytes = addressToBytes(a);

        if (addresses[node].length == 0) {
            addresses[node] = aBytes;
            addressKeys.push(a);
            addressCount++;
            emit AddressRegistered(node, a);
        } else {
            addresses[node] = aBytes;
            emit AddrChanged(node, a);
        }

        if(!nodes[node]) {
            nodeOwners[node] = a;
            nodes[node] = true;
            nodeKeys.push(node);
        }
        //allAddress[addressCount] = a;
        // addressCount++;
        //records.push(node);
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

    function isAddressMapped(bytes32 node) public view returns (bool) {
        return addresses[node].length > 0;
    }

    function deleteAddr(bytes32 node) public authorised(node) {
        if (addresses[node].length == 0) {
            revert("No record found");
        }
        delete addresses[node];
        emit AddressDeleted(node);
    }

    function supportsInterface(
        bytes4 interfaceID
    ) public view virtual override returns (bool) {
        return
            interfaceID == type(IOrchidAddrResolver).interfaceId ||
            super.supportsInterface(interfaceID);
    }
}