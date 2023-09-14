// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract PBM is Ownable, ReentrancyGuard {
    IERC20 public xSGD;
    address public whitelistedDestination;
    uint256 public expiryDate;

    constructor(
        uint256 _expiryDate,
        address _whitelistedDestination,
        address _xSGDToken
    ) {
        xSGD = IERC20(_xSGDToken);
        whitelistedDestination = _whitelistedDestination;
        expiryDate = _expiryDate;
    }

    function unwrap() external nonReentrant {
        require(
            msg.sender == owner() || block.timestamp >= expiryDate,
            "PBM: Not authorized or not expired"
        );

        uint256 balance = xSGD.balanceOf(address(this));
        xSGD.transfer(whitelistedDestination, balance);
        selfdestruct(payable(owner()));
    }
}
