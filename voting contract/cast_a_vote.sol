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

    function newProposal(address target, bytes calldata data) external {
        // TODO: create a new Proposal and add it to the proposals array
        Proposal memory newProposal = Proposal({
            target: target,
            data: data,
            yesCount: 0,
            noCount: 0
        });
        proposals.push(newProposal);
    }

    function castVote(uint proposalId, bool _supports) external {
        require(proposalId < proposals.length, "Invalid proposal ID");
        
        if (_supports) {
            proposals[proposalId].yesCount++;
        } else {
            proposals[proposalId].noCount++;
        }
    }
}