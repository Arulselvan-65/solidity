// SPDX-License-Identifier: MIT

pragma solidity 0.8.28;

contract KeyNumberStore {

    address public owner;
    mapping(string => uint256) private keyToNumber;

    error NotAllowed();
    error InvalidAddress();

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner {
        if(msg.sender != owner) revert NotAllowed();
        _;
    }

    event ValueSet(string indexed key, uint256 number, uint256 timestamp);
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    function storeNumber(string calldata key, uint256 num) external onlyOwner {
        keyToNumber[key] = num;
        emit ValueSet(key, num, block.timestamp);
    }

    function transferOwnership(address newOwner) external onlyOwner {
        if(newOwner == address(0)) revert InvalidAddress();
        address previousOwner = owner;
        owner = newOwner;
        emit OwnershipTransferred(previousOwner, newOwner);
    }

    function getValue(string calldata key) external view returns(uint256) {
        return keyToNumber[key];
    }

}