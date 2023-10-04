// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/access/Ownable.sol";

abstract contract TextConditions is Ownable {
    mapping(string => string[]) private textConditions;

    modifier checkDynamicConditions(string memory key, string memory value) {
        require(isTextConditionMet(key, value), "Text condition not met");
        _;
    }

    // Function to set a text condition
    function setTextCondition(string memory key, string[] memory values) public onlyOwner {
        textConditions[key] = values;
    }

    // Function to check if a text condition is met
    // It will check a single "value" against an array of values
    function isTextConditionMet(string memory key, string memory value) internal view returns (bool) {
        string[] memory allowedValues = textConditions[key];
        for (uint256 i = 0; i < allowedValues.length; i++) {
            if (keccak256(abi.encodePacked(allowedValues[i])) == keccak256(abi.encodePacked(value))) {
                return true;
            }
        }
        return false;
    }

    // // Function that uses the checkDynamicConditions modifier
    // function someFunction(string memory key, string memory value) public checkDynamicConditions(key, value) {
    //     // Your code here
    // }

}
