// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Normal {

    uint256 public storedValue;

    function getSender() public view returns (address) {
        return msg.sender;
    }

    function isPowerOfTwo(uint256 x) public pure returns (bool) {
        return x > 0 && (x & (x - 1)) == 0;
    }

    function setValue(uint256 _value) public {
        storedValue = _value;
    }

    function getValue() public view returns (uint256) {
        return storedValue;
    }
}