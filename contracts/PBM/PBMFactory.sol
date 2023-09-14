// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./PBM.sol";

contract PBMFactory {
    uint256 public pbmCount;
    mapping(uint256 => address) public pbmContracts;

    event PBMContractCreated(address indexed pbmContract, uint256 indexed pbmId);

    function createPBM(
        uint256 _expiryDate,
        address _whitelistedDestination
    ) external {
        PBM pbm = new PBM(_expiryDate, _whitelistedDestination, msg.sender);
        pbmCount++;
        pbmContracts[pbmCount] = address(pbm);
        emit PBMContractCreated(address(pbm), pbmCount);
    }
}
