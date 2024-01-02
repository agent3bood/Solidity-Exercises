// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract OneWeekLockup {
    /**
     * In this exercise you are expected to create functions that let users deposit ether
     * Users can also withdraw their ether (not more than their deposit) but should only be able to do a week after their last deposit
     * Consider edge cases by which users might utilize to deposit ether
     *
     * Required function
     * - depositEther()
     * - withdrawEther(uint256 )
     * - balanceOf(address )
     */

    mapping(address => uint) public balanceOf;
    mapping(address => uint) private lastDepositAt;

    function depositEther() external payable {
        balanceOf[msg.sender] += msg.value;
        lastDepositAt[msg.sender] = block.timestamp;
    }

    function withdrawEther(uint256 amount) external {
        require(balanceOf[msg.sender] >= amount);
        require(block.timestamp >= lastDepositAt[msg.sender] + 1 weeks);
        msg.sender.call{value: amount}("");
    }
}
