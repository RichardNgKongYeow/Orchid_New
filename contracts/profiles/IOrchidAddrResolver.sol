// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;

interface IOrchidAddrResolver {
    event AddressRegistered(bytes32 indexed node, address indexed a);
    event AddressUpdated(bytes32 indexed node, address indexed a);
    event AddressDeleted(bytes32 indexed node);

    function setAddr(bytes32 node, address a) external;
    function addr(bytes32 node) external view returns (address payable);
    function isAddressMapped(bytes32 hash) external view returns (bool);
    function delAddr(bytes32 node) external;
}
