// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract TimelockEscrow {
    address public seller;
    mapping(address => uint) private escrow;
    mapping(address => uint) private escrowStarted;

    /**
     * The goal of this exercise is to create a Time lock escrow.
     * A buyer deposits ether into a contract, and the seller cannot withdraw it until 3 days passes. Before that, the buyer can take it back
     * Assume the owner is the seller
     */

    constructor() {
        seller = msg.sender;
    }

    // creates a buy order between msg.sender and seller
    /**
     * escrows msg.value for 3 days which buyer can withdraw at anytime before 3 days but afterwhich only seller can withdraw
     * should revert if an active escrow still exist or last escrow hasn't been withdrawn
     */
    function createBuyOrder() external payable {
        escrow[msg.sender] = msg.value;
        escrowStarted[msg.sender] = block.timestamp;
    }

    /**
     * allows seller to withdraw after 3 days of the escrow with @param buyer has passed
     */
    function sellerWithdraw(address buyer) external {
        require(block.timestamp >= escrowStarted[buyer] + 3 days);
        (bool ok,) = seller.call{value: escrow[buyer]}("");
        require(ok);
        delete escrow[buyer];
        delete escrowStarted[buyer];
    }

    /**
     * allowa buyer to withdraw at anytime before the end of the escrow (3 days)
     */
    function buyerWithdraw() external {
        require(block.timestamp < escrowStarted[msg.sender] + 3 days);
        (bool ok,) = msg.sender.call{value: escrow[msg.sender]}("");
        require(ok);
        delete escrow[msg.sender];
        delete escrowStarted[msg.sender];
    }

    // returns the escrowed amount of @param buyer
    function buyerDeposit(address buyer) external view returns (uint256) {
        return escrow[buyer];
    }
}
