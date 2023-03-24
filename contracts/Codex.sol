// SPDX-License-Identifier: MIT
pragma solidity ^0.5.0;

import './Ownable.sol';

contract AlienCodex is Ownable {

  bool public contact;
  bytes32[] public codex;
  

  modifier contacted() {
    assert(contact);
    _;
  }
  
  function make_contact() public {
    contact = true;
  }

  function record(bytes32 _content) contacted public {
    codex.push(_content);
  }

  function retract() contacted public {
    codex.length--;
  }

  function revise(uint i, bytes32 _content) contacted public {
    codex[i] = _content;
  }
}
//web3.eth.getStorageAt('0x48Ddc869048B58aadC7a1117723Efdc5488Fa2c8', 0) => "0x00000000000000000000000040055e69e7eb12620c8ccbccab1f187883301c30"
//web3.eth.abi.decodeParameter("address", '0x00000000000000000000000040055e69e7eb12620c8ccbccab1f187883301c30') => "0x40055E69E7EB12620c8CCBCCAb1F187883301c30"  (owner)
// storage is empty at 1
//0xb10e2d527612073b26eecdfd717e6a320cf44b4afac2b0732d9fcbe2b7fa0cf6 => 0x4ef1d2ad89edf8c4d91132028e8195cdf30bb4b5053d4f8cd260341d4805f30a
//0x0000000000000000000000004085A1c6A1cEE7C3318B0c65d362B0076c35452D
//
