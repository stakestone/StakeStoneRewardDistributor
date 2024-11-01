// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {StakeStoneRewardDistributor} from "../src/StakeStoneRewardDistributor.sol";

contract StakeStoneRewardDistributorTest is Test {
    StakeStoneRewardDistributor public d;

    function setUp() public {
        d = new StakeStoneRewardDistributor();
    }

    function test_Claim() public {
        
    }

}
