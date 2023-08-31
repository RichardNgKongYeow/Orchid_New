require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
const fs = require('fs');
const MAINNET_PRIVATE_KEY = fs.readFileSync(".secret").toString().trim();
const ETH_ALCHEMY_API_KEY = ""
const ALCHEMY_API_KEY = ""
const MUMBAI_API_KEY ="456SHF73JU3BVZFMJY463RSI2GEIIJA4UN"

module.exports = {
  defaultNetwork: "mumbai",
  networks: {
    mumbai: {
      // url: https://goerli.infura.io/v3/3f6bc0d4637344c8b7efd24e118a5c45,
      url: `https://rpc-mumbai.maticvigil.com`,
      // url: `https://rpc.ankr.com/polygon_mumbai`,
      // url: `https://polygon-mumbai-bor.publicnode.com`,
      // url: https://rpc.ankr.com/eth_goerli,
      accounts: [MAINNET_PRIVATE_KEY],
      networkCheckTimeout: 999999,
      timeoutBlocks: 200,
      gas: 12400000,
      gasPrice: 17000000000,
    },
    eth_mainnet: {
      // url: https://goerli.infura.io/v3/3f6bc0d4637344c8b7efd24e118a5c45,
      url: `https://eth-mainnet.g.alchemy.com/v2/${ETH_ALCHEMY_API_KEY}`,
      // url: https://rpc.ankr.com/eth_goerli,
      accounts: [MAINNET_PRIVATE_KEY],
      networkCheckTimeout: 999999,
      timeoutBlocks: 200,
      gas: 12400000,
      gasPrice: 17000000000,
    },
    goerli: {
      // url: https://goerli.infura.io/v3/3f6bc0d4637344c8b7efd24e118a5c45,
      url: `https://eth-goerli.alchemyapi.io/v2/${ALCHEMY_API_KEY}`,
      // url: https://rpc.ankr.com/eth_goerli,
      accounts: [MAINNET_PRIVATE_KEY],
      networkCheckTimeout: 999999,
      timeoutBlocks: 200,
      gas: 12400000,
      gasPrice: 20000000000,
    },
    avalancheFujiTestnet: {
      // url: https://api.avax-test.network/ext/bc/C/rpc,
      url: `https://rpc.ankr.com/avalanche_fuji`,
      accounts: [MAINNET_PRIVATE_KEY]
    },
    avalanche: {
      url: `https://rpc.ankr.com/avalanche`,
      accounts: [MAINNET_PRIVATE_KEY],
      gasPrice: 28000000000,
    },
    fxTestnet: {
      url: `https://testnet-fx-json-web3.functionx.io:8545`,
      accounts: [MAINNET_PRIVATE_KEY],
      networkCheckTimeout: 999999,
      timeoutBlocks: 200,
      gas: 12400000,
      gasPrice: 600000000000,
    },
    fxMainnet: {
      url: `https://fx-json-web3.functionx.io:8545`,
      accounts: [MAINNET_PRIVATE_KEY],
      networkCheckTimeout: 999999,
      timeoutBlocks: 200,
      gas: 12400000,
      gasPrice: 505000000000,
    }
  },
  solidity: {
    version: "0.8.19",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },
  etherscan: {
    // Your API key for Etherscan
    // Obtain one at https://etherscan.io/
    // apiKey: ""
    apiKey: {
      mainnet: "YOUR_ETHERSCAN_API_KEY",
      optimisticEthereum: "YOUR_OPTIMISTIC_ETHERSCAN_API_KEY",
      arbitrumOne: "YOUR_ARBISCAN_API_KEY",
      bscTestnet: "",
      avalancheFujiTestnet: "",     // 
      avalanche: "",
      polygonMumbai: [MUMBAI_API_KEY]
    }
  },
};
