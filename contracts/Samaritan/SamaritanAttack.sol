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
//the transaction reverts evrytime I try to inquiry a donation, through contract and direct address..
//I should find a way to return the requestDonation bool false..
