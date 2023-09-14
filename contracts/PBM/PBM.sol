// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "../name_addressing/ICustomENSRegistry.sol"; // Import the custom ENS registry interface
import "../name_addressing/OrchidMaster.sol"; // Import the OrchidResolver

contract PBM is Ownable, ReentrancyGuard {
    using SafeMath for uint256;

    IERC20 public xSGD;
    ICustomENSRegistry public customENSRegistry; // Custom ENS Registry contract
    uint256 public expiryDate;
    uint256 public pbmPrice; // Price in xSGD to mint one PBM
    address[] public owners; // Multi-owner support

    struct WhitelistedDestination {
        bytes32 node;
        bool isActive;
    }

    mapping(address => bool) public isOwner;
    mapping(address => mapping(bytes32 => bool)) public isWhitelisted;
    WhitelistedDestination[] public whitelistedDestinations;

    event WhitelistAdded(bytes32 indexed node, address indexed owner);
    event WhitelistRemoved(bytes32 indexed node, address indexed owner);
    event PBMMinted(address indexed owner, address indexed recipient);

    constructor(
        uint256 _expiryDate,
        address[] memory _initialOwners,
        bytes32[] memory _initialWhitelist,
        uint256 _pbmPrice,
        address _customENSRegistry,
        address _xSGDToken
    ) {
        xSGD = IERC20(_xSGDToken);
        customENSRegistry = ICustomENSRegistry(_customENSRegistry);
        expiryDate = _expiryDate;
        pbmPrice = _pbmPrice;

        // Initialize owners and whitelisted destinations
        for (uint256 i = 0; i < _initialOwners.length; i++) {
            address ownerAddress = _initialOwners[i];
            owners.push(ownerAddress);
            isOwner[ownerAddress] = true;
        }

        for (uint256 i = 0; i < _initialWhitelist.length; i++) {
            bytes32 node = _initialWhitelist[i];
            whitelistedDestinations.push(WhitelistedDestination(node, true));
            isWhitelisted[msg.sender][node] = true;
        }
    }

    function addWhitelist(bytes32 node) external onlyOwner {
        require(customENSRegistry.isRecordExist(node), "PBM: Invalid ENS node");
        require(!isWhitelisted[msg.sender][node], "PBM: Node already whitelisted");

        whitelistedDestinations.push(WhitelistedDestination(node, true));
        isWhitelisted[msg.sender][node] = true;

        emit WhitelistAdded(node, msg.sender);
    }

    function removeWhitelist(bytes32 node) external onlyOwner {
        require(isWhitelisted[msg.sender][node], "PBM: Node is not whitelisted");

        for (uint256 i = 0; i < whitelistedDestinations.length; i++) {
            if (whitelistedDestinations[i].node == node) {
                whitelistedDestinations[i].isActive = false;
                isWhitelisted[msg.sender][node] = false;
                emit WhitelistRemoved(node, msg.sender);
                return;
            }
        }
    }

    function deposit(uint256 amount) external nonReentrant {
        require(amount > 0, "PBM: Amount must be greater than 0");

        // Transfer xSGD from the sender to this contract
        xSGD.transferFrom(msg.sender, address(this), amount);

        // Calculate the number of PBMs to mint based on the deposit amount
        uint256 numberOfPBMs = amount.div(pbmPrice);

        // Mint PBMs to the sender
        for (uint256 i = 0; i < numberOfPBMs; i++) {
            _mintPBM(msg.sender);
        }
    }

    function _mintPBM(address recipient) internal {
        require(recipient != address(0), "PBM: Invalid recipient");

        // Mint 1 PBM to the recipient
        pbmCount++;

        emit PBMMinted(address(this), recipient);
    }

    // Additional function for multi-owner support
    function addOwner(address newOwner) external onlyOwner {
        require(!isOwner[newOwner], "PBM: Owner already exists");
        owners.push(newOwner);
        isOwner[newOwner] = true;
    }

    function removeOwner(address ownerToRemove) external onlyOwner {
        require(isOwner[ownerToRemove], "PBM: Owner does not exist");
        require(ownerToRemove != msg.sender, "PBM: Cannot remove yourself as owner");

        for (uint256 i = 0; i < owners.length; i++) {
            if (owners[i] == ownerToRemove) {
                owners[i] = owners[owners.length - 1];
                owners.pop();
                isOwner[ownerToRemove] = false;
                return;
            }
        }
    }

    function getOwners() external view returns (address[] memory) {
        return owners;
    }

    function unwrap() external nonReentrant {
        require(
            msg.sender == owner() || block.timestamp >= expiryDate,
            "PBM: Not authorized or not expired"
        );

        for (uint256 i = 0; i < whitelistedDestinations.length; i++) {
            bytes32 node = whitelistedDestinations[i];
            require(customENSRegistry.isRecordExist(node), "PBM: Invalid ENS node");
            address resolverAddress = customENSRegistry.getResolverAddress(node);

            // Perform any additional logic with the resolver address if needed
            // Initialize OrchidResolverChild using the resolver address
            OrchidResolver orchidResolver = OrchidResolver(resolverAddress);

            // Use the addr function from OrchidResolverChild to get the address of the node
            address payable resolvedAddress = orchidResolver.addr(node);

            // Transfer xSGD to the resolved address
            uint256 balance = xSGD.balanceOf(address(this));
            xSGD.transfer(resolvedAddress, balance);
            // TODO update PBMcount
        }

        selfdestruct(payable(owner()));
    }
}
