// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Optimized {

    // 1. immutable (cheaper than storage)
    address public immutable owner;

    // 2. constant (compile-time)
    uint256 public constant MAX = 1000;

    // 3. storage packing (fewer slots used)
    uint128 public total;
    uint128 public count;

    uint256[] public numbers;

    // initializer-like pattern
    constructor() {
        owner = msg.sender;
    }

    // 4. calldata instead of memory
    function addNumbers(uint256[] calldata _nums) external {

        uint256 len = _nums.length;

        // 5. caching storage
        uint128 _total = total;

        for (uint256 i = 0; i < len; ) {

            _total += uint128(_nums[i]);

            numbers.push(_nums[i]);

            // 6. unchecked increment
            unchecked {
                i++;
            }
        }

        total = _total;
        count += uint128(len);
    }

    function check(uint256 x) external view returns (bool) {

        // 7. short-circuiting (cheaper conditions first)
        if (msg.sender != owner) return false;
        if (x <= 10) return false;
        if (x >= MAX) return false;

        return true;
    }

    // 8. event instead of redundant storage
    event NumberAdded(uint256 value);

    function addWithEvent(uint256 value) external {
        emit NumberAdded(value);
    }
}