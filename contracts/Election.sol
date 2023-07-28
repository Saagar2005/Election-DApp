// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.18;

contract Election {
    struct Voter {
        bool voted; // if true, this voter already voted
        bool registered;
    }

    struct Candidate {
        string name; // short name (up to 32 bytes)
        uint256 score; // total score
        address id;
    }

    address public leader;

    // This declares a state variable that
    // maps a `Voter` to each possible address.
    mapping(address => Voter) public voters;

    Candidate[] public candidates;

    constructor() {
        leader = msg.sender;
    }
    function regVoter() external
    {
         Voter storage voter = voters[msg.sender];
         require(voter.registered == false, "Voter is already registered");
         voter.registered = true;
    }

    function regCandidate(string memory name) external {
        address ID = msg.sender;
        uint256 flag =0;
        for(uint256 i =0; i< candidates.length;i++)
        {
            if(candidates[i].id == ID)
            {
                flag =1;
                break;
            }
        }
        if(flag==0)
        candidates.push(Candidate({name: name, score: 0, id:msg.sender}));
    }

    function isVoter() public view returns(bool isVoter_) {
        if(voters[msg.sender].registered == true)
        return true;
        else 
        return false;
    }
    function castVote(uint256[3] memory pref) external {
        Voter storage voter = voters[msg.sender];
        require(voter.registered == true,"Voter is not registered");
        require(!voter.voted, "Already voted.");
        candidates[pref[0]-1].score += 5;
        candidates[pref[1]-1].score += 3;
        candidates[pref[2]-1].score += 1;
        voters[msg.sender].voted = true;
    }
        // Determine the winning candidate.
    function winningCandidate() public view returns (uint256 winner_)
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
        require(msg.sender == leader, "Only leader can access the name of the winner");
        uint256 index = winningCandidate();
        return candidates[index].name;
    }
}
