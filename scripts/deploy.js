const hre = require("hardhat");
const namehash = require('eth-ens-namehash');

async function main() {
  
    // // CustomENSRegistry
    // const CustomENSRegistry = await hre.ethers.deployContract("CustomENSRegistry", ["0xc6a11A6024021580779cb8FFFB5014D3acc82f07"], {
    //     });

    //     await CustomENSRegistry.waitForDeployment();

    //     console.log("Contract address:", CustomENSRegistry.target);


    // // OrchidMaster
    // const OrchidMaster = await hre.ethers.deployContract("OrchidMaster", ["0xc6a11A6024021580779cb8FFFB5014D3acc82f07"], {
    //     });

    //     await OrchidMaster.waitForDeployment();

    //     console.log("Contract address:", OrchidMaster.target);


    // OrchidResolver1
    const OrchidResolverChild = await hre.ethers.deployContract("OrchidResolverChild", ["0xc6a11A6024021580779cb8FFFB5014D3acc82f07"], {
        });

        await OrchidResolverChild.waitForDeployment();

        console.log("Contract address:", OrchidResolverChild.target);
    }




main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });
  