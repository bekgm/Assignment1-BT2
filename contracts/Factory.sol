// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./ChildContract.sol";

contract Factory {

    address[] public deployedContracts;
    mapping(address => bool) public isDeployed;

    event ChildCreated(address child);
    event ChildCreated2(address child, bytes32 salt);

    function createChild(string memory name) public returns(address) {

        ChildContract child = new ChildContract(name, msg.sender);

        deployedContracts.push(address(child));
        isDeployed[address(child)] = true;

        emit ChildCreated(address(child));

        return address(child);
    }

    function createChild2(string memory name, bytes32 salt) public returns(address) {

        ChildContract child = new ChildContract{salt: salt}(name, msg.sender);

        deployedContracts.push(address(child));
        isDeployed[address(child)] = true;

        emit ChildCreated2(address(child), salt);

        return address(child);
    }

    function getDeployedContracts() public view returns(address[] memory){
        return deployedContracts;
    }
}