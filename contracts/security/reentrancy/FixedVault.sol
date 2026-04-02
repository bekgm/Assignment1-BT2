// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract FixedVault is ReentrancyGuard {

    mapping(address => uint256) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) public nonReentrant {

        require(balances[msg.sender] >= amount, "Not enough balance");

        balances[msg.sender] -= amount;

        (bool sent, ) = msg.sender.call{value: amount}("");
        require(sent, "Failed");
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}