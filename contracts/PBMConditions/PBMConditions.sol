// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;

import "../OrchidNameAddressing/registry/OrchidRegistrarController.sol";
import "./profiles/TextConditions.sol";

contract PBMConditions is TextConditions {
    OrchidRegistrarController orchidregistrarcontroller;
    
    constructor(
        address _orchidRegistrarControllerAddress,
        address _PBMOwner,
        string memory _condition // New parameter for the condition key
    ) {
        orchidregistrarcontroller = OrchidRegistrarController(_orchidRegistrarControllerAddress);
        PBMOwner = _PBMOwner;
        condition = _condition;
    }

    function checkTextValueConditionFromAddr(address addr) public view returns (bool) {
        string memory value = orchidregistrarcontroller.getTextInfoOfAddr(addr, condition);
        return isTextConditionMet(value);
    }
}
