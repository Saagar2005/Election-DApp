// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.18;

contract Election {
    struct Voter {
        bool voted; // if true, this voter already voted
        uint256 pref1; //Preferences = Indices corresponding to candidates
        uint256 pref2;
        uint256 pref3;
    }

    struct Candidate {
        string name; // short name (up to 32 bytes)
        uint256 score; // total score
    }

    // This is the leader (creator) of the election.
    address public leader;

    // This declares a state variable that
    // maps a `Voter` to each possible address.
    mapping(address => Voter) public voters;

    // A dynamically-sized array of `Candidate` structs.
    Candidate[] public candidates;

    constructor(string[] memory _candidateNames) {
        leader = msg.sender;
        for (uint256 i = 0; i < _candidateNames.length; i++) {
            candidates.push(Candidate({name: _candidateNames[i], score: 0}));
        }
    }

    function castVote(uint256 pref1, uint256 pref2, uint256 pref3) external {
        Voter storage voter = voters[msg.sender];
        require(!voter.voted, "Already voted.");
        candidates[pref1].score += 5;
        candidates[pref2].score += 3;
        candidates[pref3].score += 1;
        voters[msg.sender].voted = true;

    }

    // Determine the winning candidate.
    function winningCandidate() public view returns (uint256 winningCandidate_)
    {
        uint256 max = 0;
        for(uint256 i =1; i< candidates.length; i++)
        {
           if(candidates[i].score> candidates[max].score)
                 max = i;
        }
         require(!(candidates[max].score == 0), "No votes have been casted.");
         return max;
        // Return the index of the winner in `winningCandidate_`
        // Error and revert if no votes have been cast yet.
    }

    // Calls winningCandidate() function to get the index
    // of the winner and then returns the name of the winner
    function winningCandidateName() external view returns (string memory winnerName_)
    {
        uint256 index = winningCandidate();
        return candidates[index].name;
    }
}
