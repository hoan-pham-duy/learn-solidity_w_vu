// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract simpleAuction {
    address payable public beneficiary; 
    uint public auctionEndTime; 
    uint public highestBid;
    address public highestBidder;
    bool public ended;

    mapping (address => uint) pendingReturns;
    
    event highestBidIncrease(address bidder, uint amount);
    event auctionEnded(address winner, uint amount);

    constructor(uint _biddingTime, address payable _beneficiary){
        beneficiary = _beneficiary;
        auctionEndTime = block.timestamp + _biddingTime; 
    }

    function bid() public payable {
        if (block.timestamp > auctionEndTime) {
            revert('The auction is ended!!!');
        }

        if (msg.value <= highestBid){
            revert('Not higher than highestBid!!!');
        }
        
        if (highestBid != 0) {
            pendingReturns[msg.sender] = msg.value;
            highestBidder = msg.sender;
            highestBid = msg.value;
            emit highestBidIncrease(highestBidder, highestBid);
        }
    }

    function withdraw() public returns(bool){
       uint amount = pendingReturns[msg.sender];
       if (amount > 0){
           pendingReturns[msg.sender] = 0;
           if (!payable(msg.sender).send(amount)){
           return false;}
       }
       return true;
    }

    function auctionEnd() public {
        if (ended) {
            revert ("The session is ended");
        }
        if(block.timestamp < auctionEndTime) {
            revert("The session is not ended!!!");
        }
        
        ended = true;
        emit auctionEnded(highestBidder, highestBid);
        beneficiary.transfer(highestBid);
    }
}
