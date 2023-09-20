// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;

//import "./ICustomENSRegistry.sol"; // Import the ICustomENSRegistry interface
import "../registry/OrchidRegistry.sol";
import "./OrchidResolver.sol";

contract OrchidMaster {
    address owner;
    address registry;

    struct ResolverInfo {
        address resolverAddress;
        string resolverName;
        address owner;
    }

    mapping(uint => ResolverInfo) public resolvers;
    uint public resolverCount = 0;

    ResolverInfo[] public resolverInfos;

    mapping(string => uint256) public resolverNameToIndex;

    event ResolverCreated(address indexed resolverAddress, string indexed resolverName, address indexed owner);

    /**
     * 
     * @param _owner Address of the owner of this contract
     * @param _registry Address of the Orchid registry
     */
    constructor(address _owner, address _registry) {
        owner = _owner;
        registry = _registry;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    /**
     * @notice Create a new orchid resolver
     * @param _owner Address of the owner of the orchid resolver
     * @param _resolverName Name of the resolver
     * @param _registry Add of the Orchid registry
     */
    function createResolver(address _owner, string calldata _resolverName, address _registry) external onlyOwner {
        OrchidResolver newResolver = new OrchidResolver(_owner, _registry);
        resolverInfos.push(ResolverInfo(address(newResolver), _resolverName, _owner));
        resolverNameToIndex[_resolverName] = resolverInfos.length - 1;

        resolvers[resolverCount] = ResolverInfo(address(newResolver), _resolverName, _owner);
        resolverCount++;
        emit ResolverCreated(address(newResolver), _resolverName, _owner);
    }

    function getAllResolvers() public view returns (ResolverInfo[] memory) {
        ResolverInfo[] memory id = new ResolverInfo[](resolverCount);
        for (uint i = 0; i < resolverCount; i++) {
            ResolverInfo storage resolver = resolvers[i];
            id[i] = resolver;
        }
        return id;
    }

    // // TODO delete this? This is the same as the resolvers
    // function getResolver(uint256 index) external view returns (Resolver memory) {
    //     require(index < resolvers.length, "Index out of bounds");
    //     return resolvers[index];
    // }

    function getResolverInfoByName(string calldata _resolverName) external view returns (ResolverInfo memory) {
        uint256 index = resolverNameToIndex[_resolverName];
        require(index < resolverInfos.length, "Resolver not found");
        return resolverInfos[index];
    }

    function getResolverCount() external view returns (uint256) {
        return resolverInfos.length;
    }

    function getResolverInfos() external view returns (address[] memory resolverAddresses, string[] memory resolverNames, address[] memory owners) {
        uint256 length = resolverInfos.length;
        resolverAddresses = new address[](length);
        resolverNames = new string[](length);
        owners = new address[](length);

        uint256 validCount = 0;
        for (uint256 i = 0; i < length; i++) {
            if(true) {
                resolverAddresses[validCount] = resolverInfos[i].resolverAddress;
                resolverNames[validCount] = resolverInfos[i].resolverName;
                owners[validCount] = resolverInfos[i].owner;
                validCount++;
            }
        }
        assembly {
            mstore(resolverAddresses, validCount)
            mstore(resolverNames, validCount)
            mstore(owners, validCount)
        }

        return (resolverAddresses, resolverNames, owners);
    }
}