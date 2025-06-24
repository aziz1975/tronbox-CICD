// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

contract SimpleStorage {
    uint256 private storedData;
    mapping(address => uint256) public balances;

    constructor(uint256 initialValue) {
        storedData = initialValue;
    }

    function set(uint256 x) public {
        storedData = x;
    }

    function get() public view returns (uint256) {
        return storedData;
    }

    /// @notice Deposit TRX into your balance
    function deposit() external payable {
        require(msg.value > 0, "Send TRX to deposit");
        balances[msg.sender] += msg.value;
    }

    /// @notice Withdraw your entire balance safely
    function withdraw() external {
        uint256 bal = balances[msg.sender];
        require(bal > 0, "No balance");

        // 1) update state first
        balances[msg.sender] = 0;

        // 2) use high-level transfer instead of low-level call
        payable(msg.sender).transfer(bal);
    }

    /// @dev Accept plain TRX transfers into your balance
    receive() external payable {
        balances[msg.sender] += msg.value;
    }
}
