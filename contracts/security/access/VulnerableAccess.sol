// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract VulnerableAccess {

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    // ❌ любой может стать owner
    function setOwner(address _owner) public {
        owner = _owner;
    }

    function withdraw() public {
        payable(msg.sender).transfer(address(this).balance);
    }

    receive() external payable {}
}