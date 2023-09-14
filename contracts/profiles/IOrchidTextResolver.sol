// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;

interface IOrchidTextResolver {
    event TextRegistered(bytes32 indexed node, string indexed key, string value);
    event TextChanged(bytes32 indexed node, string indexed key, string value);
    event TextDeleted(bytes32 indexed node, string indexed key);
    event KeySet(bytes32 indexed node, string indexed key);

    function setKey(bytes32 node, string calldata key) external;
    function setText(bytes32 node, string calldata key, string calldata value) external;
    function text(bytes32 node, string calldata key) external view returns (string memory);
    function delText(bytes32 node, string calldata key) external;
}
