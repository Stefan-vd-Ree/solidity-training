// Layout of a Contract //
// License
// Version
// Imports
// Errors
// Interfaces, libraries, contracts
// Type declarations
// State variables
// Events
// Modifiers
// Functions
    // Constructor
    // Receive
    // Fallback
    // External
    // Public
    // Internal
    // Private
    // View & Ppure

// License
// SPDX-License-Identifier: MIT

// Version
pragma solidity ^0.8.18; //Solidity version, carrot means use any higher minor version if available

// Imports

    contract YourContractName { //start of contract
        // Errors
        // you can use custom errors to safe a abit of gas. You emit this with an if statement test and revert command. Gas on polygon isn't an issue, code is more readable with require()

        // Interfaces, libraries, contracts

        // Type declarations

        // State variables
        address payable owner; //an address can only be send currency is the address is defined as payable

        // Events

        // Modifiers

        constructor(){
        // this runs on deploy
        // initialize state
        }

        receive() external payable {
        // this is a default function for when money is sent to this contract
    }
        fallback() external payable {
        // this is a default function for when a non-existant function is called on this contract
    }

    // External functions
    // Public functions // public means people can use it, payable is required whenever a function needs to be send currency
    // Internal functions
    // Private functions
    // View & Ppure functions

    function yourFunction() public { 
        // Checks, first all checks, requirements, any reasons the transaction should be discontinued

        // Effects, second, changes of state, changes of balances. This would all be reverted if for some reason the transaction fails

        // Interactions, lastly actual interactions like transfer of funds, transfer of NFTs, withdrawals, trading, etc etc
    }
}