// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;

interface IReverseRegistrar {
    function setNameForAddr(address a, bytes32 node) external;
    function node(address a) external view returns (bytes32);
}
