// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract VulnerableVault {

    mapping(address => uint256) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) public {
        require(balances[msg.sender] >= amount, "Not enough balance");

        // УЯЗВИМОСТЬ: external call ДО обновления баланса
        (bool sent, ) = msg.sender.call{value: amount}("");
        require(sent, "Failed");

        balances[msg.sender] -= amount;
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}