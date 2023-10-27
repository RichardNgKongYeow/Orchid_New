// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;

abstract contract TextConditions {
    address public PBMOwner;
    address public PBMContractAddr;
    string public condition;

    event TextConditionSet(string value, bool isSet);
    event PBMContractSet(address contractAddress);

    mapping(string => bool) public textConditions;
    string[] public allConditionValues;


    modifier onlyPBMOwner() {
        require(msg.sender == PBMOwner || msg.sender == PBMContractAddr, "Only the PBM owner can call this function");
        _;
    }

    function setPBMContract(address contractAddress) public onlyPBMOwner {
        PBMContractAddr = contractAddress;
        emit PBMContractSet(contractAddress);
    }

    function setTextCondition(string memory value, bool isSet) public onlyPBMOwner {
        textConditions[value] = isSet;
        allConditionValues.push(value);
        emit TextConditionSet(value, isSet);
    }

    function removeTextCondition(string memory value) public onlyPBMOwner {
        delete textConditions[value];
        for (uint256 i = 0; i < allConditionValues.length; i++) {
            if (keccak256(abi.encodePacked(allConditionValues[i])) == keccak256(abi.encodePacked(value))) {
                allConditionValues[i] = allConditionValues[allConditionValues.length - 1];
                allConditionValues.pop();
                break;
            }
        }
    }

    function isTextConditionMet(string memory value) public view returns (bool) {
        return textConditions[value];
    }

    function getAllConditionValues() public view returns (string[] memory) {
        return allConditionValues;
    }

    function getCondition() public view returns (string memory) {
        return condition;
    }

}
