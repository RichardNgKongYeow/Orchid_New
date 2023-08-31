// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");
const namehash = require('eth-ens-namehash');

async function main() {
  
  // // ENSRegistry
  // const ensRegistry = await hre.ethers.deployContract("ENSRegistry", [], {
  // });

  // await ensRegistry.waitForDeployment();

  // console.log("Contract address:", ensRegistry.target);

  // // ENSRegistrar
  // console.log(namehash.hash("test"))
  // const ensRegistrar = await hre.ethers.deployContract("FIFSRegistrar", ["0x5878f74B6E06b32B194Ee7A8a8E7647fA71064E8", namehash.hash("test")], {
  // });

  // await ensRegistrar.waitForDeployment();
  // // change the address to a var
  // console.log("Contract address:", ensRegistrar.target);

  // // BaseRegistrarImplementation
  // const BaseRegistrarImplementation = await hre.ethers.deployContract("BaseRegistrarImplementation", ["0x5878f74B6E06b32B194Ee7A8a8E7647fA71064E8", namehash.hash("orchid")], {
  // });

  // await BaseRegistrarImplementation.waitForDeployment();
  // // change the address to a var
  // console.log("Contract address:", BaseRegistrarImplementation.target);


  // // StaticMetadataService
  // const StaticMetadataService = await hre.ethers.deployContract("StaticMetadataService", ["ens-metadata-service.appspot.com/name/0x{id}"], {
  // });

  // await StaticMetadataService.waitForDeployment();
  // // change the address to a var
  // console.log("Contract address:", StaticMetadataService.target);

  // // NameWrapper
  // const NameWrapper = await hre.ethers.deployContract("NameWrapper", ["0x5878f74B6E06b32B194Ee7A8a8E7647fA71064E8","0x74e084f44B86f06D2f6c8C10546E0A60a9CFB8Fa","0x2Cc1Bb66D8f1E705Cbd680a92D2658F8a14E352b"], {
  // });

  // await NameWrapper.waitForDeployment();
  // // change the address to a var
  // console.log("Contract address:", NameWrapper.target);

  // // DummyOracle
  // const DummyOracle = await hre.ethers.deployContract("DummyOracle", ["160000000000"], {
  // });

  // await DummyOracle.waitForDeployment();
  // // change the address to a var
  // console.log("Contract address:", DummyOracle.target);

  // // ExponentialPremiumPriceOracle
  // const ExponentialPremiumPriceOracle = await hre.ethers.deployContract("ExponentialPremiumPriceOracle", ["0xdE22d67e61D1Faec3d8006d6D51492c84f128613",[0,0,20294266869609,5073566717402,158548959919],"100000000000000000000000000","21"], {
  // });

  // await ExponentialPremiumPriceOracle.waitForDeployment();
  // // change the address to a var
  // console.log("Contract address:", ExponentialPremiumPriceOracle.target);

  // // ExponentialPremiumPriceOracle
  // const ExponentialPremiumPriceOracle = await hre.ethers.deployContract("ExponentialPremiumPriceOracle", ["0xdE22d67e61D1Faec3d8006d6D51492c84f128613",[0,0,20294266869609,5073566717402,158548959919],"100000000000000000000000000","21"], {
  // });

  // await ExponentialPremiumPriceOracle.waitForDeployment();
  // // change the address to a var
  // console.log("Contract address:", ExponentialPremiumPriceOracle.target);

  // // ENSRegistryWithFallback
  // const ENSRegistryWithFallback = await hre.ethers.deployContract("ENSRegistryWithFallback", ["0x5878f74B6E06b32B194Ee7A8a8E7647fA71064E8"], {
  // });

  // await ENSRegistryWithFallback.waitForDeployment();
  // // change the address to a var
  // console.log("Contract address:", ENSRegistryWithFallback.target);

  // // ReverseRegistrar
  // const ReverseRegistrar = await hre.ethers.deployContract("ReverseRegistrar", ["0x9C625E253E1cf0b1be4c9FcF36417F9c9889307E"], {
  // });

  // await ReverseRegistrar.waitForDeployment();
  // // change the address to a var
  // console.log("Contract address:", ReverseRegistrar.target);

  // // ETHRegistrarController
  // const ETHRegistrarController = await hre.ethers.deployContract("ETHRegistrarController", ["0x74e084f44B86f06D2f6c8C10546E0A60a9CFB8Fa","0x8333e696f9d2075b9d515361D0d622e8d13F7323", "60", "86400", "0x8cA2151704Fc654eebE420318E38D42E9B9DA55F", "0x57243941774b19f149901A57904123EEB51e64b3"], {
  // });

  // await ETHRegistrarController.waitForDeployment();
  // // change the address to a var
  // console.log("Contract address:", ETHRegistrarController.target);


  // PublicResolver
  const PublicResolver = await hre.ethers.deployContract("PublicResolver", ["0x9C625E253E1cf0b1be4c9FcF36417F9c9889307E","0x57243941774b19f149901A57904123EEB51e64b3", "0x805D1bDa299089Bac846C736deebF7aD95Fd2D8A","0x8cA2151704Fc654eebE420318E38D42E9B9DA55F"], {
  });

  await PublicResolver.waitForDeployment();
  // change the address to a var
  console.log("Contract address:", PublicResolver.target);

  // // CustomENS
  // const CustomENS = await hre.ethers.deployContract("CustomENS", [], {
  // });

  // await CustomENS.waitForDeployment();
  // // change the address to a var
  // console.log("Contract address:", CustomENS.target);

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
