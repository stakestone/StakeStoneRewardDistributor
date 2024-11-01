// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {StakeStoneRewardDistributor} from "../src/StakeStoneRewardDistributor.sol";

contract DeployScript is Script {
    StakeStoneRewardDistributor public d;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        d = new StakeStoneRewardDistributor();

        vm.stopBroadcast();
    }
}
