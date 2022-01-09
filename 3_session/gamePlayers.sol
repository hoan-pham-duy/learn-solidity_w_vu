// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
contract Game {
  uint public countPlayer = 0;
  mapping (address => Player) public players;
  enum Level {Begin, Intermediate, Advance}

  struct Player {
    address addressPlayer;
    string fullName;
    Level level;
    uint age;
    string sex;
  }
  
  function addPlayer(string memory fullName, uint age, string memory sex) public {
    players[msg.sender] = Player(msg.sender, fullName, Level.Begin, age, sex);
    countPlayer += 1;  
  }
}
