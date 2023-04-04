// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "forge-std/Test.sol";
import "../src/ConfidentialHash.sol";

contract ConfidentialHashTest is Test {
    // the identifiers of the forks
    uint256 goerliFork;

    //Access variables from .env file via vm.envString("varname")
    //Replace ALCHEMY_KEY by your alchemy key or Etherscan key, change RPC url if need
    //inside your .env file e.g:
    string GOERLI_RPC_URL = vm.envString("GOERLI_RPC_URL");
    
    address confidential = 0xf8E9327E38Ceb39B1Ec3D26F5Fad09E426888E66;

    // function setUp() external {
    //     vm.createSelectFork(GOERLI_RPC_URL);
    //     hashed
    // }

    // function test_CheckGetters() external {
    //     console.log(confidential.firstUser());
    // }
}