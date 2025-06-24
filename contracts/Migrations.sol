// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

contract Migrations {
    // 1) Mark owner immutable
    address public immutable owner;

    // 2) Use mixedCase naming
    uint public lastCompletedMigration;

    constructor() {
        owner = msg.sender;
    }

    modifier restricted() {
        require(
            msg.sender == owner,
            "This function is restricted to the contract's owner"
        );
        _;
    }

    function setCompleted(uint completed) public restricted {
        lastCompletedMigration = completed;
    }
}
