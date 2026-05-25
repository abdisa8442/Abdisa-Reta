// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    receive() external payable {
        // This function allows the contract to receive Ether
    }

    function tip() external payable {
        payable(owner).transfer(msg.value);
    }
}// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

