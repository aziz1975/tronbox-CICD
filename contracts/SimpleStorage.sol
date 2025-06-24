// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

contract SimpleStorage {
    uint256 private storedData;
    mapping(address => uint) public balances;

    constructor(uint256 initialValue) {
        storedData = initialValue;
    }

    function set(uint256 x) public {
        storedData = x;
    }

    function get() public view returns (uint256) {
        return storedData;
    }

        // Vulnerable to reentrancy
    function withdraw() external {
        uint bal = balances[msg.sender];
        require(bal > 0, "No balance");

        balances[msg.sender] = 0;
        (bool success,) = msg.sender.call{value: bal}("");
        
        require(success, "Transfer failed");
	    


    }
}
