// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ChildContract {

    address public owner;
    string public name;

    constructor(string memory _name, address _owner) payable {
        owner = _owner;
        name = _name;
    }

    receive() external payable {}

    function getBalance() public view returns(uint256){
        return address(this).balance;
    }
}