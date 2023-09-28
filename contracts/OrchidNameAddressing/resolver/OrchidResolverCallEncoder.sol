// // SPDX-License-Identifier: MIT
// pragma solidity >=0.8.4;

// import "./OrchidResolver.sol";

// contract OrchidResolverCallEncoder {
//     OrchidResolver public orchidResolver;

//     constructor(address _orchidResolverAddress) {
//         orchidResolver = OrchidResolver(_orchidResolverAddress);
//     }

//     // Function to encode the call data for setAddrAndName
//     function encodeSetAddrAndName(
//         bytes32 node,
//         address a,
//         string memory name
//     ) public pure returns (bytes memory) {
//         // Encode the function selector for setAddrAndName
//         bytes4 selector = orchidResolver.setAddrAndName.selector;

//         // Encode the parameters for the function
//         bytes memory data = abi.encodePacked(
//             selector,
//             node,
//             a,
//             bytes(name)
//         );

//         return data;
//     }

//     // Function to execute the encoded call data on OrchidResolver
//     function executeSetAddrAndName(
//         bytes memory encodedData
//     ) public {
//         // Call the setAddrAndName function on OrchidResolver
//         (bool success, ) = address(orchidResolver).call(encodedData);
//         require(success, "Call to setAddrAndName failed");
//     }
// }
