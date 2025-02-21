// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract IdiotBettingGame {
    /*
        This exercise assumes you know how block.timestamp works.
        - Whoever deposits the most ether into a contract wins all the ether if no-one 
          else deposits after an hour.
        1. `bet` function allows users to deposit ether into the contract. 
           If the deposit is higher than the previous highest deposit, the endTime is 
           updated by current time + 1 hour, the highest deposit and winner are updated.
        2. `claimPrize` function can only be called by the winner after the betting 
           period has ended. It transfers the entire balance of the contract to the winner.
    */

    address private winner;
    uint private lastBetAmount;
    uint private lastBetAt;

    function bet() public payable {
        lastBetAt = block.timestamp;
        if (msg.value > lastBetAmount) {
            winner = msg.sender;
        }
    }

    function claimPrize() public {
        require(msg.sender == winner);
        require(block.timestamp > lastBetAt + 1 hours);
        msg.sender.call{value: address(this).balance}("");
    }
}
