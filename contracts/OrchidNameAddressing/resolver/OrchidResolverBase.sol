// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;    
import "hardhat/console.sol";
import "./IOrchidResolverBase.sol";

abstract contract OrchidResolverBase is IOrchidResolverBase{
    address contractOwner;
    bytes32[] nodeKeys;
    mapping (bytes32 => bool) nodes;

    event Transfer(address owner);

    function isOwner(bytes32 node) internal view virtual returns (bool);

    modifier onlyOwner(bytes32 node) {
        require(isOwner(node), "Only owner can call this function");
        _;
    }

    // modifier onlyOwner() {
    //     require(msg.sender == owner, "Only owner can call this function");
    //     _;
    // }

    // modifier nodeExists(bytes32 node) {
    //     require(records[node], "Node does not exist");
    //     _;
    // }
    
    function setOwner(address _contractOwner) public {
        require(msg.sender == contractOwner, "Only owner can call this function");
        contractOwner = _contractOwner;
        emit Transfer(contractOwner);
    }

    function supportsInterface(
        bytes4 interfaceID
    ) public view virtual override returns (bool) {
        return
            interfaceID == type(IOrchidResolverBase).interfaceId ||
            supportsInterface(interfaceID);
    }


}

