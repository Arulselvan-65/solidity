// SPDX-License-Identifier: MIT

pragma solidity 0.8.28;

contract KeyNumberStore {

    address private immutable owner;
    mapping(string => uint256) public keyToNumber;

    error NotAllowed();

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner {
        if(msg.sender != owner) revert NotAllowed();
        _;
    }

    event UpdatedNumber(string indexed key, uint256 number, uint256 timestamp);

    function storeNumber(string calldata key, uint256 num) external onlyOwner {
        keyToNumber[key] = num;
        emit UpdatedNumber(key, num, block.timestamp);
    }

}