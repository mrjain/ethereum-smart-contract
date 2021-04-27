# Creating an ERC-20 token (aka crypto-currency)

---
A straight forward implemention of the ERC-20 standard to write a smart contract for creating a new crypto-currency token. The token is called "The Rari Token" with a symbol of "ENZO"...I'll let you figure out which car company I'm referencing!

## What you will learn?

- Installing the developer tools - Node.js, Truffle Framework, Ganache GUI and MetaMask
- Deploy the smart contract to Ganache a personal Ethereum blockchain
- Using the Infura.io service to access the test and production Ethereum blockchain
- Deploy the smart contract to Roptsen (test network) and Mainnet (production network)
- Use MetaMask, an Ethereum wallet, to see the newly created cryptocurrency in your account

## How to use this repo

There are two ways to use this repo. The first method is to git clone this repo and install the packages. The second method is step by step of what needs to get done, this is longer but so much more beneficial if you are new to Ethereum, ERC-20, Solidity, smart contracts, etc...

## Option 1: Clone this repo

Via the cli (aka terminal), clone the GitHub to your local machine:

```bash
git clone https://github.com/mrjain/ethereum-smart-contract your-directory-name
```

From the above directory, install the node packages that are required and referenced in the package.json file:

```bash
npm install
```

Initiate the Truffle framework, but don't overwrite the files.

```bash
truffle init
```

Then once you download Ganache and complile the code you can then deploy it. The instructions for that are further down below.

## Pre-Requirements

First you will install Node.js and npm, this tutorial assumes you are using the MacOS:

- Node.js - <https://nodejs.org/en/download/>
- npm (Node Package Manager) - comes with Node.js

Download Ganache

- Ganache - <https://www.trufflesuite.com/ganache>

Download MetaMask - a Chrome browser extension

- MetaMask - <https://metamask.io/>

## Option 2: Building the project folder structure and installing the dependencies

Via the cli (aka terminal), we're going to create a folder and navigate to it.

```bash
mkdir my-token
cd my-token
```

Now we're going to initiate a new npm project by typing the following command, and leaving blank the inputs by pressing enter.

```bash
npm init
```

Install the Truffle framework. Truffle is a development environment, testing framework and asset pipeline for Ethereum.

```bash
npm install -g truffle
```

Check to make sure Truffle was installed correctly. It will also install Solidity the programming language to write smart contracts and Web3.js which is the library to connect to the blockchain.

```bash
truffle version
```

Install the Truffle wallet to connect MetaMask to the Ethereum blockchain. I've specified v1.2.2 because there are issues with other versions.

```bash
npm install @truffle/hdwallet-provider@1.2.2
```

Install the OpenZeppelin Smart Contract package.

```bash
npm install @openzeppelin/contracts
```

Install the dotenv package, which loads environment variables from a .env file.

```bash
npm install dotenv
```

Initiate a new Truffle framework project.

```bash
truffle init
```

## Create an account on Infura

Goto <https://infura.io/> and create an account. This will allow you to deploy the smart contract to a test and production Ethereum blockchain. Once you create a project, copy the Project ID which you will need for the following step.

## Create an .env file

Create a new dot env file to store the secret keys for the wallet account and Infura Project ID.

```bash
touch .env
```

Open the file in your text editor and add the following:

```bash
INFURA_PROJECT_ID=c0d55...
WALLET_PRIVATE_KEY=b1823...
```

## Edit the truffle-config.js file

Edit the truffle-config.js file by adding the following 2 lines:

```javascript
require('dotenv').config();
const HDWalletProvider = require('@truffle/hdwallet-provider');
```

Then add the following lines for the 3 environments:

```javascript
dev: {
  host: "127.0.0.1",     // Localhost (default: none)
  port: 7545,            // Standard Ethereum port (default: none)
  network_id: "*",       // Any network (default: none)
},
ropsten: {
  provider: () => new HDWalletProvider(process.env.WALLET_PRIVATE_KEY, "https://ropsten.infura.io/v3/" + process.env.INFURA_PROJECT_ID),
  network_id: 3,
  gas: 5000000,
  gasPrice: 25000000000  
},
mainnet: {
  provider: () => new HDWalletProvider(process.env.WALLET_PRIVATE_KEY, "https://mainnet.infura.io/v3/" + process.env.INFURA_PROJECT_ID),
  network_id: 1,
  confirmations: 2,
  gas: 5000000,
  gasPrice: 25000000000
},
```

For the compiler section add the following:

```javascript
compilers: {
    solc: {
      version: "0.8.0",    // Fetch exact version from solc-bin (default: truffle's version)
        docker: false,        // Use "0.5.1" you've installed locally with docker (default: false)
        settings: {          // See the solidity docs for advice about optimization and evmVersion
        optimizer: {
           enabled: false,
           runs: 200
         },
        evmVersion: "byzantium"
       }
    }
  },
```

## Create an ERC20 smart contract file

In the contracts directory create a new file called MyToken.sol:

```bash
touch MyToken.sol
```

Open the file and add the following:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import '@openzeppelin/contracts/token/ERC20/ERC20.sol';

contract MyToken is ERC20 {

    constructor () ERC20("The Rari Token", "ENZO") {
        _mint(msg.sender, 1000000 * 10 ** 18);
    }
}
```

This imports the ERC20 smart contracts file from the OpenZeppelin project. The name of the token is called "The Rari Token" and the symbol is "ENZO". It will mint 1,000,000 tokens and will have 18 decimal places.

## Create a new migration/deploy file

In the migrations directory create a new file called 2_deploy.js:

```bash
touch 2_deploy.js
```

Open the file to add the logic to deploy the MyToken file by adding the following:

```javascript
var MyToken = artifacts.require("./MyToken.sol");

module.exports = function(deployer){
    deployer.deploy(MyToken)
}
```

## Start Ganache

Click on the previously downloaded Ganache file to start the personal Ethereum blockchain environment.

## Compile the smart contract

Any changes made to the .sol file new to be recompiled before deploying them. From the CLI of the directory type:

```bash
truffle compile
```

## Migration/deploy the smart contract to Ganache

To deploy the smart contract to the Ganache personal blockchain, type the following:

```bash
truffle migrate 
```

If you need to run the migrations and reset everything, use the following:

```bash
truffle migrate --reset
```

## Migration/deploy the smart contract to Ropsten

You will first need to get some test Ether for Ropsten using a faucet,
goto: <https://faucet.dimensions.network/> and enter your Ethereum address to get some Ether. Once you have test Ether, deploy the smart contract to the Ropsten testing blockchain by typing the following:

```bash
truffle migrate --reset --network ropsten
```

## Migration/deploy the smart contract to Mainnet - the production Ethereum blockchain

You will first need to get some REAL Ether for Mainnet. This is it! **We are talking REAL MONEY here.** Once you have Ether, deploy the smart contract to Mainnet by typing the following:

```bash
truffle migrate --reset --network mainnet
```

Copy the contract address that was created and go to <https://etherscan.io/> and paste it. **BOOM...You just created your own crypto-currency!**
