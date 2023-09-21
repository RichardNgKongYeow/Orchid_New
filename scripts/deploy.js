const hre = require("hardhat");
const namehash = require('eth-ens-namehash');

async function main() {
  
    // OrchidRegistry
    const OrchidRegistry = await hre.ethers.deployContract("OrchidRegistry", [], {
        });

        await OrchidRegistry.waitForDeployment();

        console.log("OrchidRegistry address:", OrchidRegistry.target);


    // OrchidMaster
    const OrchidMaster = await hre.ethers.deployContract("OrchidMaster", ["0xc6a11A6024021580779cb8FFFB5014D3acc82f07",OrchidRegistry.target], {
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
  