// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;




abstract contract TextConditions {
    mapping(string => mapping(string => bool)) private textConditions;
    string[] private conditionKeys;
    mapping(string => string[]) private conditions;
    address public _PBMOwner;

    event TextConditionSet(string indexed key, string indexed value, bool condition);
    event TextConditionRemoved(string indexed key, string indexed value);

    modifier onlyPBMOwner() {
        require(msg.sender == _PBMOwner, "Only the PBM owner can call this function");
        _;
    }
    // Function to set a text condition
    function setTextCondition(string memory key, string memory value) public onlyPBMOwner {
        textConditions[key][value] = true;
        conditions[key].push(value);
        if (!contains(conditionKeys, key)) {
            conditionKeys.push(key);
        }
        emit TextConditionSet(key, value, true);
    }

    // Function to remove a text condition
    function removeTextCondition(string memory key, string memory value) public onlyPBMOwner {
        require(textConditions[key][value], "Text condition does not exist");
        delete textConditions[key][value];
        emit TextConditionRemoved(key, value);
    }

    // Function to check if a text condition is met
    function isTextConditionMet(string memory key, string memory value) public view returns (bool) {
        if (textConditions[key][value]) {
            return true;
        } else {
            return false;
        }
    }

    // Function to get all condition keys
    function getAllConditionKeys() public view returns (string[] memory) {
        return conditionKeys;
    }

    // Function to get all conditions for a specific key
    function getAllConditionsForKey(string memory key) public view returns (string[] memory) {
        return conditions[key];
    }

    // Helper function to check if an array contains a specific value
    function contains(string[] storage array, string memory value) internal view returns (bool) {
        for (uint256 i = 0; i < array.length; i++) {
            if (keccak256(abi.encodePacked(array[i])) == keccak256(abi.encodePacked(value))) {
                return true;
            }
        }
        return false;
    }


}
