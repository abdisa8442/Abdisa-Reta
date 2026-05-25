// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "./Hero.sol";

// TODO: create Mage/Warrior Heroes

contract Mage is Hero {
    constructor() Hero() {
        // Mage-specific initialization can go here if needed
    }
}

contract Warrior is Hero {
    constructor() Hero() {
        // Warrior-specific initialization can go here if needed
    }
}