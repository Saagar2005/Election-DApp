import { ethers } from "./ethers.js";

// check if MetaMask exists
if (typeof window.ethereum !== 'undefined') {
    console.log('MetaMask is installed!');
}

// create a new ethers.js provider using that MetaMask instance
const provider = new ethers.providers.Web3Provider(window.ethereum);

const contractAddress = "0x5FbDB2315678afecb367f032d93F642f64180aa3";
const signer = provider.getSigner();

const abi =  [
    {
      "inputs": [],
      "stateMutability": "nonpayable",
      "type": "constructor"
    },
    {
      "inputs": [
        {
          "internalType": "uint256",
          "name": "",
          "type": "uint256"
        }
      ],
      "name": "candidates",
      "outputs": [
        {
          "internalType": "string",
          "name": "name",
          "type": "string"
        },
        {
          "internalType": "uint256",
          "name": "score",
          "type": "uint256"
        },
        {
          "internalType": "address",
          "name": "id",
          "type": "address"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [
        {
          "internalType": "uint256[3]",
          "name": "pref",
          "type": "uint256[3]"
        }
      ],
      "name": "castVote",
      "outputs": [],
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "isVoter",
      "outputs": [
        {
          "internalType": "bool",
          "name": "isVoter_",
          "type": "bool"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "leader",
      "outputs": [
        {
          "internalType": "address",
          "name": "",
          "type": "address"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [
        {
          "internalType": "string",
          "name": "name",
          "type": "string"
        }
      ],
      "name": "regCandidate",
      "outputs": [],
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "regVoter",
      "outputs": [],
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "inputs": [
        {
          "internalType": "address",
          "name": "",
          "type": "address"
        }
      ],
      "name": "voters",
      "outputs": [
        {
          "internalType": "bool",
          "name": "voted",
          "type": "bool"
        },
        {
          "internalType": "bool",
          "name": "registered",
          "type": "bool"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "winningCandidate",
      "outputs": [
        {
          "internalType": "uint256",
          "name": "winner_",
          "type": "uint256"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "winningCandidateName",
      "outputs": [
        {
          "internalType": "string",
          "name": "winnerName_",
          "type": "string"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    }
  ]

  const contract = new ethers.Contract(contractAddress, abi, signer);


document.getElementById('RegVoter').onclick = contract.regVoter();
document.getElementById('show').innerHTML=contract.condidates;
contract.castVote(document.getElementById('fpref').value ,document.getElementById('spref').value,document.getElementById('tpref').value);
contract.regCandidate(document.getElementById('name').value);
document.getElementById('winner').innerHTML=contract.condidates;
