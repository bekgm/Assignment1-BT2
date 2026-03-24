// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Assembly {

    uint256 public storedValue;

    // 1. Получение msg.sender через assembly
    function getSender() public view returns (address sender) {
        assembly {
            sender := caller()
        }
    }

    // 2. Проверка степени двойки (power of 2)
    function isPowerOfTwo(uint256 x) public pure returns (bool result) {
        assembly {
            // x > 0 && (x & (x - 1)) == 0
            result := and(gt(x, 0), iszero(and(x, sub(x, 1))))
        }
    }

    // 3. Прямой доступ к storage (slot 0)
    function setValue(uint256 _value) public {
        assembly {
            sstore(0, _value)
        }
    }

    function getValue() public view returns (uint256 value) {
        assembly {
            value := sload(0)
        }
    }
}