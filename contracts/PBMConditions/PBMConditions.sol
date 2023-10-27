// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;

import "../OrchidNameAddressing/registry/OrchidRegistrarController.sol";
import "./profiles/TextConditions.sol";


contract PBMConditions is TextConditions {
    OrchidRegistrarController orchidregistrarcontroller;

    constructor(
        address _orchidRegistrarControllerAddress,
        address PBMOwner
        )  
        {
        orchidregistrarcontroller = OrchidRegistrarController(_orchidRegistrarControllerAddress);
        _PBMOwner = PBMOwner;
    }

    function checkTextValueConditionFromAddr(address addr, string calldata key) public view returns (bool) {
        string memory string_value = orchidregistrarcontroller.getTextInfoOfAddr(addr, key);
        return isTextConditionMet(key,string_value);
    }

}
