// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Contract {
	enum Choices { Yes, No }
	
	struct Vote {
		Choices choice;
		address voter;
	}
	
	// TODO: create a public state variable: an array of votes
	Vote[] public votes;

	function createVote(Choices choice) external {
		// TODO: add a new vote to the array of votes state variable
		votes.push(Vote(choice, msg.sender));
	}

	// Shared helper function to find a vote by address
	function _findVoteByAddress(address addr) private view returns (Vote storage) {
		for (uint i = 0; i < votes.length; i++) {
			if (votes[i].voter == addr) {
				return votes[i];
			}
		}
		revert("Vote not found");
	}

	function hasVoted(address addr) external view returns (bool) {
		for (uint i = 0; i < votes.length; i++) {
			if (votes[i].voter == addr) {
				return true;
			}
		}
		return false;
	}

	function findChoice(address addr) external view returns (Choices) {
		for (uint i = 0; i < votes.length; i++) {
			if (votes[i].voter == addr) {
				return votes[i].choice;
			}
		}
		revert("Vote not found");
	}
}