// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../lib/foundry-huff/src/HuffDeployer.sol";
import "../src/CollatzPuzzle.sol";
import "../src/CollatzPuzzleSolution.huff";

contract CollatzPuzzleTest is Test {
    CollatzPuzzle public collatz;
    address public solution;

    function setUp() external {
        collatz = new CollatzPuzzle();
        solution = HuffDeployer.deploy("CollatzPuzzleSolution");
    }

    function test_callMe() external {
        // vm.prank(address(collatz));
        collatz.callMe(address(solution));
    }
}

interface CollatzPuzzle {
    function collatzIteration(uint256) external returns(uint256);
}