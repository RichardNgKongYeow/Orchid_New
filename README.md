# Orchid_New

# Orchid
> npm install
> then follow the compile and deploy instructions


## New Project and running it
> npm init -y
> npm install --save-dev hardhat
> npx hardhat
> npm install --save-dev @nomicfoundation/hardhat-toolbox
> npm install --save-dev @nomiclabs/hardhat-etherscan
> npm i @openzeppelin/contracts-upgradeable
> npm i @openzeppelin/contracts
> npx hardhat run src/backend/scripts/deploy.js --network localhost

# Compiling and deploying
> `npx hardhat compile`

> `npx hardhat run scripts/deploy.js --network`

> `npx hardhat verify --network mumbai 0x57f9C4ae0282bBD5ba99fbd874B941912eAB88aA`

> `npx hardhat verify --constructor-args arguments.js --network mumbai 0x64df72dFb0CB35DE0764398745D4e149c36Ea090`

> `npx hardhat verify --contract contracts/OrchidResolverChild.sol:OrchidResolverChild --constructor-args arguments.js --network mumbai 0xa190cc5e4fbd67a576d8801124be8e92a1d03008`



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

# v3
CustomENSRegistry: 0x3690b6c986Ac0226C9b6723E0cc92fFe0240b3B7
OrchidMaster: 0x2152b0f28725F4418E520F42614F39f1726aEaa8
grab 0x633849ee92d4fa07790f52200a472cbd0a745b3d7b305ee861e8174479fa0a82
Resolver1: 0x18BAedE26E7722476bf4B120B689b9fA6e27ba9e
uob 0x85b0601a4f6c3f0af1bc16587f70f1eb7ddb6c93b763d4c3848206cca8934f3f
Resolver2: 0x379a48592c613F80C2c14d56Cf446FfEece751F7

# v4
CustomENSRegistry address: 0xfFC3c162bFdB3a9bF79B6fBB010f859491Eb0e25
OrchidMaster address: 0x7C04167915A19aaDDb25D8666d594Fc2A90D0836
grab 0x633849ee92d4fa07790f52200a472cbd0a745b3d7b305ee861e8174479fa0a82
Resolver1: 0xa190cc5e4fbd67a576d8801124be8e92a1d03008

# v5
OrchidRegistry address: 0x1E82D212710C3A88dd12620DcE666D24Bd657019
OrchidMaster address: 0x929E054f0cF4316A3D21e9A519b3764E04CA7b85
grab: 0x633849ee92d4fa07790f52200a472cbd0a745b3d7b305ee861e8174479fa0a82

# v6
OrchidRegistry address: 0x0b3c02307CA3db39c9511B34943705938027c83E
OrchidMaster address: 0xA95A0d911732726D8148aB1049BeB7b6046f1b89
grab: 0x633849ee92d4fa07790f52200a472cbd0a745b3d7b305ee861e8174479fa0a82
Resolver1 (owner:0xc6a11A6024021580779cb8FFFB5014D3acc82f07, resolvername: 0x633849ee92d4fa07790f52200a472cbd0a745b3d7b305ee861e8174479fa0a82): 0x0A3CbFEBa9Cb7749A4BA465dd494E673A9D20233

# v7
OrchidRegistry address: 0x6BDc5D42E5f047a12fA8cf6366CE6414c451f277
OrchidMaster address: 0x57f9C4ae0282bBD5ba99fbd874B941912eAB88aA
grab: 0x633849ee92d4fa07790f52200a472cbd0a745b3d7b305ee861e8174479fa0a82
Resolver1: 0x64df72dFb0CB35DE0764398745D4e149c36Ea090