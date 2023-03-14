// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Mod2 {
    bool public enter = false;

    modifier gateThree(bytes8 _gateKey) {
        require(
            uint64(bytes8(keccak256(abi.encodePacked(msg.sender)))) ^
                uint64(_gateKey) ==
                type(uint64).max
        );
        _;
    }

    function enterin(
        bytes8 _gateKey
    ) public gateThree(_gateKey) returns (bool) {
        enter = true;
        return true;
    }
}

contract AttackGateK {
    Mod2 public gateK;

    constructor(address _gateK) {
        gateK = Mod2(_gateK);
        uint64 result = uint64(bytes8(keccak256(abi.encodePacked(msg.sender)))) ^ type(uint64).max;
        bytes8 answer = bytes8 (result);
        gateK.enterin(answer);
    }
}
