// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./profiles/TextConditions.sol"; // Import the TextConditions contract
import "@openzeppelin/contracts/access/Ownable.sol"; // Import the Ownable contract

contract PBMConditions is Ownable, TextConditions {

    constructor() {
    }


}