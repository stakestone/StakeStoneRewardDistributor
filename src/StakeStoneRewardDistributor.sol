// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.26;

import {TransferHelper} from "@uniswap/v3-periphery/contracts/libraries/TransferHelper.sol";
import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

contract StakeStoneRewardDistributor is AccessControl {
    bytes32 public constant SETTER_ROLE = keccak256("SETTER_ROLE");

    bytes32 public root;

    mapping(address => mapping(address => uint256)) public claimed;

    // Constructor
    constructor() {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    // Public
    function claim(bytes32[] memory _proof, address _token, uint256 _totalClaimableAmount, uint256 _claimAmount)
        external
    {
        bytes32 leaf = keccak256(bytes.concat(keccak256(abi.encode(msg.sender, _token, _totalClaimableAmount))));
        require(MerkleProof.verify(_proof, root, leaf), "Invalid proof");
        claimed[msg.sender][_token] += _claimAmount;
        require(claimed[msg.sender][_token] <= _totalClaimableAmount, "Invalid amount");
        TransferHelper.safeTransfer(_token, msg.sender, _claimAmount);
    }

    // Owner
    function setRoot(bytes32 _root) external onlyRole(SETTER_ROLE) {
        root = _root;
    }
}
