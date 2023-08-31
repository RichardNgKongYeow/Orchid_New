// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;

contract StringToBytes32Mapping {
    mapping(bytes32 => string) private stringMapping;

    function mapStringToBytes32(string memory name, bytes32 hash) external {
        require(bytes(name).length > 0, "Name must not be empty");
        require(bytes(stringMapping[hash]).length == 0, "Hash already mapped");
        stringMapping[hash] = name;
    }

    function getString(bytes32 hash) external view returns (string memory) {
        return stringMapping[hash];
    }

    function stringToBytes32(string memory input) public pure returns (bytes32) {
        return keccak256(bytes(input));
    }
}