// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;


interface ISamaritan {
    function requestDonation() external returns(bool enoughBalance);

}

contract AttackSamaritan {
    ISamaritan samaritan;


    constructor(address _samaritan) public{
        samaritan = ISamaritan(_samaritan);

    }

    function attackSamaritan() public payable {
        samaritan.requestDonation();
    }
    fallback() external payable {
        samaritan.requestDonation();
    }


}
//it seems like I cannot perform a reentrancy attack..
//let's check the balance of coins that I still have left in my balance
//maybe I should check the wallet of the coins or try to make a require balance == 0
