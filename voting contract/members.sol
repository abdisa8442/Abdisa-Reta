// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Voting {
    struct Proposal {
        address target;
        bytes data;
        uint yesCount;
        uint noCount;
    }
    
    // TODO: create a public array of type Proposal and call it proposals
    Proposal[] public proposals;
    
    // Track votes: proposalId => voter => hasVoted (bool)
    mapping(uint => mapping(address => bool)) public hasVoted;
    // Track vote choice: proposalId => voter => supported (bool)
    mapping(uint => mapping(address => bool)) public voteChoice;

    // Events
    event ProposalCreated(uint proposalId);
    event VoteCast(uint proposalId, address voter);

    // Mapping to track authorized members
    mapping(address => bool) public isMember;

    // Constructor takes an array of addresses and adds them plus the deployer as members
    constructor(address[] memory _members) {
        isMember[msg.sender] = true;
        for (uint i = 0; i < _members.length; i++) {
            isMember[_members[i]] = true;
        }
    }

    // Modifier to restrict access to members only
    modifier onlyMember() {
        require(isMember[msg.sender], "Only members can call this function");
        _;
    }

    function newProposal(address target, bytes calldata data) external onlyMember {
        // TODO: create a new Proposal and add it to the proposals array
        Proposal memory newProposal = Proposal({
            target: target,
            data: data,
            yesCount: 0,
            noCount: 0
        });
        uint proposalId = proposals.length;
        proposals.push(newProposal);
        emit ProposalCreated(proposalId);
    }

    function castVote(uint proposalId, bool _supports) external onlyMember {
        require(proposalId < proposals.length, "Invalid proposal ID");
        
        // Check if the voter has already voted on this proposal
        if (hasVoted[proposalId][msg.sender]) {
            // Get their previous vote
            bool previousVote = voteChoice[proposalId][msg.sender];
            
            // If the vote is changing, adjust counts
            if (previousVote != _supports) {
                if (_supports) {
                    // Changing from no to yes
                    proposals[proposalId].noCount--;
                    proposals[proposalId].yesCount++;
                } else {
                    // Changing from yes to no
                    proposals[proposalId].yesCount--;
                    proposals[proposalId].noCount++;
                }
                // Update their vote choice
                voteChoice[proposalId][msg.sender] = _supports;
            }
            // If same vote, do nothing (no change to counts)
        } else {
            // First time voting
            if (_supports) {
                proposals[proposalId].yesCount++;
            } else {
                proposals[proposalId].noCount++;
            }
            hasVoted[proposalId][msg.sender] = true;
            voteChoice[proposalId][msg.sender] = _supports;
        }
        
        // Emit event for every vote cast
        emit VoteCast(proposalId, msg.sender);
    }
}