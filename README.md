# Project Report: Gymkhana Elections DApp
## 1. Introduction
Welcome to the Gymkhana Elections DApp, a decentralized application (dApp) that operates on a peer-to-peer (P2P) network of computers connected through the Ethereum blockchain. Unlike traditional applications controlled by a single authority, dApps like ours embrace transparency and autonomy.  This enables our campus junta to engage in the election process without fear of censorship or manipulation.

This user manual gives you a gist of the Gymkhana Elections DApp, including its functionalities, how to use the application, and the technologies used.

## 2. Getting started
Please note that the user needs to have MetaMask installed and have testnet Ether (ETH) available to perform actions within the DApp.

## 3. Application Overview
This application facilitates the registration of voters and candidates. Voters can cast their vote, and the leader can access the result.Leader is the creator of the election.The voter gives three preferences (which are the indices (natural numbers) corresponding to the intended candidates).The scores corresponding to the three preferences are 5, 3, and 1.That candidate whose total score is the highest is declared as the winner of the election.

## 4. How to run
1. Install dependencies
 '''  
npm install
'''
2. Run the hardhat node. This will create 20 accounts with 10000 ETH each. 
'''
npx hardhat node
'''
3. Connect the node with Metamask

Go to Metamask > Click on networks tab > Click on add network > Add network manually > Fill in the following details

'''
Network Name: localhost

RPC URL: http://localhost:8545

Chain ID: 31337

Currency Symbol: ETH
'''

4. Add some accounts to Metamask (Use the private keys from the hardhat node).

Go to Metamask > Click on account icon > Import account > Paste the private key > Click on Import


5. Deploy the contract
'''
npx hardhat run scripts/deploy.js --network localhost
'''
6.Load the frontend using VSCode Live Server extension.

Right click on index.html > Open with Live Server

7.Interact with the frontend.
