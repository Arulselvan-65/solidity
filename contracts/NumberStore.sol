// SPDX-License-Identifier: MIT

pragma solidity 0.8.28;

contract NumberStore {

    address private immutable owner;
    uint256 public number;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Not Allowed");
        _;
    }

    event NumberUpdated(uint256 number, uint256 timestamp);

    function store(uint256 _num) external onlyOwner {
        number = _num;
        emit NumberUpdated(number, block.timestamp);
    }
}