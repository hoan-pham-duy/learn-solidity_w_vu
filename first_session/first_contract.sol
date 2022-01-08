// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.1;

contract firstcontract {
    uint public saveData;

    function set(uint x) public {
        saveData = x;
    }

    function get() public view returns (uint x) {
        return saveData;
    }
}