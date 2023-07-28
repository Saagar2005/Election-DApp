pragma solidity ^0.8.9;

contract GymkhanaElection {
    struct Candidate {
        string name;
        uint256 voteCount;
        address candidateAddress;
    }

    struct Voter {
        bool registered;
        bool voted;
        address[] preferences;
    }

    address public owner;
    uint256 public registrationDeadline;
    uint256 public votingDeadline;
    uint256 public totalVotes;
    Candidate[] public candidates;
    mapping(address => Voter) public voters;

    event CandidateRegistered(string name);
    event VoterRegistered(address voter);
    event VoteCast(address voter, address[] preferences);
    event ElectionResult(string winner, uint256 voteCount);

    constructor(uint256 _registrationDeadline, uint256 _votingDeadline) {
        owner = msg.sender;
        registrationDeadline = _registrationDeadline;
        votingDeadline = _votingDeadline;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    modifier onlyRegisteredVoter() {
        require(voters[msg.sender].registered, "Only registered voter can call this function");
        _;
    }

    modifier beforeRegistrationDeadline() {
        require(block.timestamp < registrationDeadline, "Registration deadline has passed");
        _;
    }

    modifier beforeVotingDeadline() {
        require(block.timestamp < votingDeadline, "Voting deadline has passed");
        _;
    }

    function registerCandidate(string memory _name, address _candidateAddress) public onlyOwner beforeRegistrationDeadline {
        candidates.push(Candidate(_name, 0, _candidateAddress));
        emit CandidateRegistered(_name);
    }

    function registerVoter(address _voter) public onlyOwner beforeRegistrationDeadline {
        voters[_voter].registered = true;
        emit VoterRegistered(_voter);
    }

    function castVote(address[] memory _preferences) public onlyRegisteredVoter beforeVotingDeadline {
        require(!voters[msg.sender].voted, "You have already voted");
        require(_preferences.length == candidates.length, "Invalid number of preferences");

        uint256[] memory points = new uint256[](3);
        points[0] = 5;
        points[1] = 3;
        points[2] = 1;

        for (uint256 i = 0; i < _preferences.length; i++) {
            require(voters[msg.sender].preferences.length < 3, "You can only vote for three candidates");
            require(voters[msg.sender].preferences.length == i || _preferences[i] != voters[msg.sender].preferences[i], "Duplicate vote");

            voters[msg.sender].preferences.push(_preferences[i]);
            candidates[getIndex(_preferences[i])].voteCount += points[i];
            totalVotes += points[i];
        }

        voters[msg.sender].voted = true;
        emit VoteCast(msg.sender, _preferences);
    }

    function declareWinner() public onlyOwner {
        require(block.timestamp >= votingDeadline, "Voting is still ongoing");

        uint256 maxVoteCount = 0;
        uint256 winnerIndex = 0;

        for (uint256 i = 0; i < candidates.length; i++) {
            if (candidates[i].voteCount > maxVoteCount) {
                maxVoteCount = candidates[i].voteCount;
                winnerIndex = i;
            }
        }

        emit ElectionResult(candidates[winnerIndex].name, maxVoteCount);
    }

    function getIndex(address _candidate) private view returns (uint256) {
        for (uint256 i = 0; i < candidates.length; i++) {
            if (candidates[i].candidateAddress == _candidate) {
                return i;
            }
        }
        revert("Candidate not found");
    }
}
