// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract FirstCoin {
    address public minter;
    mapping (address => uint) public balances;
    event sent(address from, address to, uint amount); 
    constructor () {
        minter = msg.sender;
    }

    modifier checkMinter() {
        require(msg.sender == minter, "Excepion: Only the minter can mint");
        _;//Only run when it is called
    }

    modifier checkAmount(uint amount) {
        require(amount < 1e60, "Exception: amount too large");
        _;
    }

    modifier checkBalance(uint amount) {
        require(amount <= balances[msg.sender], "Exception: Not enough money to send");
        _;
    }

    function mint(address receiver, uint amount) public checkMinter checkAmount(amount) {
        balances[receiver] += amount;
    }

    function send(address receiver, uint amount) public checkBalance(amount) {
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit sent(msg.sender, receiver, amount);
    }
}
