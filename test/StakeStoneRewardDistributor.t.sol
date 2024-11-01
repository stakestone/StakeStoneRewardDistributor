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

        bytes32[] memory proof = new bytes32[](2);
        proof[0] = 0x6f67952441151b318fe497cb66f76cc7a7eac3d3393685327f333d46aea75b57;
        proof[1] = 0x8e33d2181623a3904ed57ae5aa3c221005089b00d84d8ac342e5973feffc47f1;

        vm.startPrank(0x2222222222222222222222222222222222222222);
        d.claim(proof, EIGEN, 25 * 10 ** 17, 24 * 10 ** 17);
        d.claim(proof, EIGEN, 25 * 10 ** 17, 1 * 10 ** 17);
    }
}
