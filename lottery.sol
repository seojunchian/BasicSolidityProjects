//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Lottery{

    address public manager;
    address payable[] public players;
    address payable public winner;

    constructor () {
        manager = msg.sender;
    }

    modifier payToEnter() {
        require(msg.value==1 ether, "cant enter without paying");
        _;
    }

    function enter() public payable payToEnter {
        players.push(payable(msg.sender));
    }

    function random() public view returns(uint) {
        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players))) % 10;
    }

    function wonTheMoney() public view returns(uint) {
        return players.length;
    }

    function pickWinner() public {
        winner = players[random()];
        winner.transfer(wonTheMoney() * 1 ether);
    }

}
