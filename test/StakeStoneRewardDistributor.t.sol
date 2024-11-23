// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {StakeStoneRewardDistributor} from "../src/StakeStoneRewardDistributor.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract StakeStoneRewardDistributorTest is Test {
    StakeStoneRewardDistributor public d;
    address EIGEN = 0xec53bF9167f50cDEB3Ae105f56099aaaB9061F83;

    function setUp() public {
        uint256 mainnetFork = vm.createFork("https://1rpc.io/eth");
        vm.selectFork(mainnetFork);

        d = new StakeStoneRewardDistributor();
        d.grantRole(d.SETTER_ROLE(), address(this));

        deal(EIGEN, address(d), 10000 * 10 ** 18);
    }

    function test_Claim() public {
        d.setRoot(0xe93fb4943d9900427cf2ad2e4797ff74c8b62885d6fe5fbd504ac0d476857fd5);

        bytes32[][] memory proofs = new bytes32[][](1);
        bytes32[] memory proof = new bytes32[](2);
        proof[0] = 0x6f67952441151b318fe497cb66f76cc7a7eac3d3393685327f333d46aea75b57;
        proof[1] = 0x8e33d2181623a3904ed57ae5aa3c221005089b00d84d8ac342e5973feffc47f1;
        proofs[0] = proof;

        address[] memory tokens = new address[](1);
        tokens[0] = EIGEN;

        uint256[] memory totalAmounts = new uint256[](1);
        totalAmounts[0] = 25 * 10 ** 17;

        uint256[] memory claim1Amounts = new uint256[](1);
        claim1Amounts[0] = 22 * 10 ** 17;

        uint256[] memory claim2Amounts = new uint256[](1);
        claim2Amounts[0] = 1 * 10 ** 17;

        vm.startPrank(0x2222222222222222222222222222222222222222);
        d.claim(proofs, tokens, totalAmounts, claim1Amounts);
        d.claim(proofs, tokens, totalAmounts, claim2Amounts);

        vm.startPrank(address(this));
        d.startTerminate();
        vm.warp(block.timestamp + 31 days);
        d.finalTerminate(tokens);
    }
}
