// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;

interface ICustomENSRegistry {
    function setRecord(bytes32 node, bytes32 resolverName, address resolver) external;
    function getRecord(bytes32 node) external view returns (bytes32, address);
    function deleteRecord(bytes32 node) external;
    function isRecordExist(bytes32 node) external view returns (bool);
    function getResolverAddress(bytes32 node) external view returns (address);
    function getResolverName(bytes32 node) external view returns (bytes32);
}
