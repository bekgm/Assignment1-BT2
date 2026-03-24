// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Unoptimized {

    uint256 public total;
    uint256 public max = 1000;
    address public owner;

    uint256[] public numbers;

    constructor() {
        owner = msg.sender;
    }

    function addNumbers(uint256[] memory _nums) public {
        for (uint256 i = 0; i < _nums.length; i++) {
            total += _nums[i];
            numbers.push(_nums[i]);
        }
    }

    function check(uint256 x) public view returns (bool) {
        if (x > 10 && x < max && msg.sender == owner) {
            return true;
        }
        return false;
    }
}