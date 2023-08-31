const hre = require("hardhat");
const namehash = require('eth-ens-namehash');

async function main() {
  
    // // CustomENS
    // const CustomENS = await hre.ethers.deployContract("CustomENS", [], {
    // });

    // await CustomENS.waitForDeployment();

    // console.log("Contract address:", CustomENS.target);

    // // StringToBytes32Mapping
    // const StringToBytes32Mapping = await hre.ethers.deployContract("StringToBytes32Mapping", [], {
    // });

    // await StringToBytes32Mapping.waitForDeployment();

    // console.log("Contract address:", StringToBytes32Mapping.target);

    // // OrchidRegistry
    // const OrchidRegistry = await hre.ethers.deployContract("OrchidRegistry", [CustomENS.target, StringToBytes32Mapping.target], {
    // });

    // await OrchidRegistry.waitForDeployment();

    // console.log("Contract address:", OrchidRegistry.target);
    // OrchidMaster

    const OrchidMaster = await hre.ethers.deployContract("OrchidMaster", [], {
        });

        await OrchidMaster.waitForDeployment();

        console.log("Contract address:", OrchidMaster.target);

    }
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });
  