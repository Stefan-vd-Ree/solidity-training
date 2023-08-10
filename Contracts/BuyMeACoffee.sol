// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18; //Solidity version, carrot means use any higher minor version if available


contract BuyMeACoffee { //start of contract
    //Errors
    error CoffeeIsntFree();
    // Event to emit when a memo is created.
    event NewMemo(
        uint256 indexed timestamp, //indexed means that the variable will be indexes and can be used in queries in the future. More gas expensive, so use continuously
        string message
    );

    struct Memo { //struct are custom variables that can contain multiple elements.
        uint256 timestamp;
        string message;
    }

    // List of all memos received
    Memo[] memos; // Array, named memos, of self-defined structure Memo

    address payable owner;
    

    constructor(){
        owner = payable(msg.sender);

    }

    receive() external payable {
    // this is a default function for when money is sent to this contract
    }
    fallback() external payable {
    // this is a default function for when a non-existant function is called on this contract
    }

    // Buy coffee or the owner of the contract
    function buyCoffee(string memory _message) external payable { // By setting the function as external instead of public we are slightly more gas efficient but can't call the function from within the contract
        require(msg.value > 0, "Coffee isn't free, regretfully :/");

        // Add the memo to storage
        memos.push(Memo(
            block.timestamp,
            _message
            ));
        
        // Emit a log event
        emit NewMemo(
            block.timestamp,
            _message
            );
        
    }

    // Withdraw the tips received since the last withdrawal
    function withdrawTips() public{
        require(msg.sender == owner, "This coffee wasn't bought for you, naughty boy/girl!");

        (bool callSuccess, ) = owner.call{value: address(this).balance}("");
        require(callSuccess, "withdrawTips failed");
    }

    // Retrieve all the memos received and stored on the blockchain
    function getMemos() public view returns(Memo[] memory){
        return memos;
    }

}
