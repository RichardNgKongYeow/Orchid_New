const hre = require("hardhat");
const namehash = require('eth-ens-namehash');

async function main() {
  
    // CustomENSRegistry
    const CustomENSRegistry = await hre.ethers.deployContract("CustomENSRegistry", ["0xc6a11A6024021580779cb8FFFB5014D3acc82f07"], {
        });

        await CustomENSRegistry.waitForDeployment();

        console.log("CustomENSRegistry address:", CustomENSRegistry.target);


    // OrchidMaster
    const OrchidMaster = await hre.ethers.deployContract("OrchidMaster", ["0xc6a11A6024021580779cb8FFFB5014D3acc82f07"], {
        });

        await OrchidMaster.waitForDeployment();

        console.log("OrchidMaster address:", OrchidMaster.target);


    // // OrchidResolver1
    // const OrchidResolver = await hre.ethers.deployContract("OrchidResolver", ["0xc6a11A6024021580779cb8FFFB5014D3acc82f07"], {
    //     });

    //     await OrchidResolver.waitForDeployment();

    //     console.log("OrchidResolver address:", OrchidResolver.target);
    }




main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });
  