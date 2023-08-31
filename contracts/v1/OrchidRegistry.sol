// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;

import "./StringToBytes32Mapping.sol";
import "./CustomENS.sol";

contract OrchidRegistry {
    address public owner;
    mapping(address => bool) public operators;
    mapping(bytes32 => address) public owners;

    CustomENS private customENSContract;
    StringToBytes32Mapping private mappingContract;
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    modifier onlyOperator() {
        require(operators[msg.sender], "Only operator can call this function");
        _;
    }

    constructor(address customENSAddress, address mappingContractAddress) {
        owner = msg.sender;
        customENSContract = CustomENS(customENSAddress);
        mappingContract = StringToBytes32Mapping(mappingContractAddress);
    }

    function setOwner(address newOwner) public onlyOwner {
        owner = newOwner;
    }

    function addOperator(address operator) public onlyOwner {
        operators[operator] = true;
    }

    function removeOperator(address operator) public onlyOwner {
        operators[operator] = false;
    }

    function mapNameToAddress(string memory name, address addr) public onlyOperator {
        bytes32 hash = mappingContract.stringToBytes32(name);  // Hash the name
        require(!customENSContract.isAddressMapped(hash), "Name already mapped to an address");
        customENSContract.setAddr(hash, addr);
        mappingContract.mapStringToBytes32(name, hash);
    }
    
    function getAddressFromName(string memory name) public view returns (address) {
        bytes32 hash = mappingContract.stringToBytes32(name);  // Hash the name
        return customENSContract.addr(hash);
    }


}
