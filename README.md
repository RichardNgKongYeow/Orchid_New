# Orchid_New

# Orchid

## New Project and running it
> npm init -y
> npm install --save-dev hardhat
> npx hardhat
> npm install --save-dev @nomicfoundation/hardhat-toolbox
> npm install --save-dev @nomiclabs/hardhat-etherscan
> npm i @openzeppelin/contracts-upgradeable
> npm i @openzeppelin/contracts
> npx hardhat run src/backend/scripts/deploy.js --network localhost


> `npx hardhat compile`

>`npx hardhat run scripts/deploy.js --network`

> `npx hardhat verify --network mumbai 0x8821Af3eeDC3DA804ed0c22d664c77b2d3C5DF98`

> `npx hardhat verify --constructor-args arguments.js --network mumbai 0x035e384bAD3A138c0eDec616a8CC6A5Bce46D926`

> `npx hardhat verify --contract contracts/OrchidResolver.sol:OrchidResolver --constructor-args arguments.js --network mumbai 0x035e384bAD3A138c0eDec616a8CC6A5Bce46D926`


wallet creation script Setting up

1. If you have older versions of python say python 3.8.8
2. Install virtual env. `python -m pip install --user virtualenv`
3. Create virtual env. `python -m venv env`
4. Activate `virtual env source env/bin/activate`
    Windows: `env\Scripts\activate`
5. Install dependencies `pip install -r requirements.txt`



## Backend

### Creating Data and Updating `accounts.csv`

To create data and update the `accounts.csv` file based on the specifications, follow these steps:

1. Open the project's Address_DB directory.

2. Implement the necessary Python scripts or functions to generate the required data according to the given specifications. This could involve reading data from various sources, processing it, and creating the desired output.

3. Once the data is generated, update the `accounts.csv` file with the new data. The `accounts.csv` file is typically a CSV (Comma-Separated Values) file that contains information about different accounts, such as usernames, emails, passwords, etc. Make sure the data is formatted correctly and follows the expected structure.

4. Ensure that the `accounts.csv` file is located in the appropriate directory accessible by the backend scripts.

5. If your backend application involves database management, consider updating the database with the new data as well.

6. Test the backend scripts thoroughly to ensure that the data creation and update processes work as expected.

7. Optionally, you can provide example commands or instructions on how to run the Python scripts to create data and update the `accounts.csv` file.

8. Update the Readme with any relevant information or notes on the data creation process, including any potential pitfalls or issues that might arise.

Remember to include any other specific instructions or details that are relevant to your project's backend setup. These steps are just a general guide to help you get started with updating the backend part of the Readme based on the specifications provided.



# Dependencies
1. react router: `npm install react-router-dom@6`
2. ipfs: `npm install ipfs-http-client@56.0.1`
3. openzeppelin: `npm i @openzeppelin/contracts@4.5.0`
4. run `npx hardhat compile` see what dependencies are missing and run `npm install` followed by package name
5. you will have to resolve each of the ENS pragma solidity versions

# Configs
1. `hardhat.config.js`: paths to where artifacts are
2. 


To run:
1. to run webapp: `npm run start`
2. to run blockchain: `npx hardhat node`
3. deploy script: `npx hardhat run src/backend/scripts/deploy.js --network localhost`

To clear cache:
1. `npx hardhat clean`
2. `npx hardhat compile`

Deployed contracts:

# ENS Originial
ENSRegistry: 0x5878f74B6E06b32B194Ee7A8a8E7647fA71064E8

FIFSRegistrar: 0x85b9Ae952ff1dE4e2D8Cd98182e042e8093AaD96

BaseRegistrarImplementation: 0x74e084f44B86f06D2f6c8C10546E0A60a9CFB8Fa

StaticMetadataService: 0x2Cc1Bb66D8f1E705Cbd680a92D2658F8a14E352b

NameWrapper: 0x57243941774b19f149901A57904123EEB51e64b3

DummyOracle: 0xdE22d67e61D1Faec3d8006d6D51492c84f128613

ExponentialPremiumPriceOracle: 0x8333e696f9d2075b9d515361D0d622e8d13F7323

ENSRegistryWithFallback (newENS): 0x9C625E253E1cf0b1be4c9FcF36417F9c9889307E

ReverseRegistrar: 0x8cA2151704Fc654eebE420318E38D42E9B9DA55F

ETHRegistrarController: 0x805D1bDa299089Bac846C736deebF7aD95Fd2D8A

PublicResolver: 0x96EE4CB215C08263B2b692Ec166b12BF245BAC15

namehash(richard.orchid): 0x3ea29fa7c97dc98185b32912dc28b85de9aeee0cfa3a310ac2485ece62169f41

namehash(orchid): 0x7cbf672508aa888df6d5417cf1e3d36454f248586d13df959021b8456a4ca943

namehash(richard): 0x9c8919e3cc7a0d95ca5ba01fdb7400c796ae5ac508f3eaef0c4596df4aacd081

# v1
CustomENS: 0xE031565DD6f33Ec27EdDF3e5A6DE0906cb4a04e3
StringToBytes32Mapping: 0xeD6fc68BAEF59B2B9c1FC351e78289CFDf9a7383
OrchidRegistry: 0x4cDbaDA845A7c0fe24CbDe9a943f6fF569944FE7

OrchidMaster: 0xd91eD8EB7427e25CEF8BA7E71D3C2D4C323de2AC
OrchidResolver: 0x7586c21FFD4D592607CAC7b278AB60A4032b7364

# v2
CustomENSRegistry: 0x91dd764aEa8caf3E5D05271657df8073871E277e
OrchidMaster: 0x75bd21Eb291839a89e10d7a52Fb1dB73dEa07386
Resolver1: 0x035e384bAD3A138c0eDec616a8CC6A5Bce46D926