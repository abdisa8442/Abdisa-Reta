// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    uint8 public a = 100;      // uint8 value between 0-255 (choose any, e.g., 100)
    uint16 public b = 256;     // uint16 value at least 256
    uint256 public sum = a + b; // sum of a and b as uint256
}