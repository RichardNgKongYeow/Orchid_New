// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


abstract contract TextConditions {
    mapping(string => string[]) public conditions;
    string[] public conditionKeys;

    // Function to add a new condition and update the keys array
    function addCondition(string memory key, string[] memory values) public  {
        require(conditions[key].length == 0, "Condition key already exists");
        conditions[key] = values;
        conditionKeys.push(key);
    }

    // Function to update an existing condition
    function updateCondition(string memory key, string[] memory values) public {
        require(conditions[key].length > 0, "Condition key does not exist");
        conditions[key] = values;
    }

    // Function to delete an existing condition and remove it from the keys array
    function deleteCondition(string memory key) public {
        require(conditions[key].length > 0, "Condition key does not exist");
        delete conditions[key];
        for (uint256 i = 0; i < conditionKeys.length; i++) {
            if (keccak256(abi.encodePacked(conditionKeys[i])) == keccak256(abi.encodePacked(key))) {
                if (i != conditionKeys.length - 1) {
                    conditionKeys[i] = conditionKeys[conditionKeys.length - 1];
                }
                conditionKeys.pop();
                break;
            }
        }
    }

    // Function to check if a text condition is met
    function isTextConditionMet(string memory key, string memory value) public view returns (bool) {
        string[] memory allowedValues = conditions[key];
        for (uint256 i = 0; i < allowedValues.length; i++) {
            if (keccak256(abi.encodePacked(allowedValues[i])) == keccak256(abi.encodePacked(value))) {
                return true;
            }
        }
        return false;
    }

    // Function to get all condition keys
    function getAllConditionKeys() public view returns (string[] memory) {
        return conditionKeys;
    }

    // Function to get all conditions for a specific key
    function getAllConditionsForKey(string memory key) public view returns (string[] memory) {
        return conditions[key];
    }
}
