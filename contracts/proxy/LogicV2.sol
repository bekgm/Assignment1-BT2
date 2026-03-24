// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./LogicV1.sol";

contract LogicV2 is LogicV1 {

    function decrement() public {
        counter--;
    }

    function reset() public {
        counter = 0;
    }
}