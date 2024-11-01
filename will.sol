// Will & Inheritance Issue

// express the use of solidty and the version

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

// set up the conditions
contract Will {
    // define the variables used in the contract
    address owner; // special type
    uint    fortune;
    bool    deceased;

    // special type of function that executes for each contract
    constructor() payable public { // visible even outside this contract
        // initialize variables
        owner = msg.sender; // built in method represenation of who is calling the address, here, the grand father
        fortune = msg.value; // built in global method, how much Ether is being sent?
        deceased = false; 
    }

    // create modifier so that the only person who can call the contract is the owner
    modifier onlyOwner {
        require(msg.sender == owner); // verify condition
        _; // shift back to the function, if not, stopping the people that are not owner to access to the function
    }

    // create modifier so that so that we only allocate funds when friend's grandpa's deceased
    modifier mustBeDeceased {
        require(deceased == true); // verify condition
        _; // shift back to the function, if not, stopping the people that are not owner to access to the function
    }
    
    // list - store all the addresses
    address payable [] famillyWallet; 

    // iterate through stored values (in address array) in inheritance
    mapping (address => uint) inheritance;

    // set values
    function setInheritance(address payable wallet, uint amount) public onlyOwner { // only the owner is allow to set
        // add wallets to the famillyWallet
        famillyWallet.push(wallet);
        inheritance[wallet] = amount;
    }

    // now, automate the paiements based on their wallet address (transfer)
    function payout() private mustBeDeceased { // only exectued if condition is true (modifier)
        for (i=0; i<famillyWallet.length; i++) 
        {
            famillyWallet[i].transfer(inheritance[famillyWallet[i]]); // transfert from the contract address to the receiver address
        };
    }

}