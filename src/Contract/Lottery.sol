// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Lottery{

    event winnerChosen(uint prize, address winner);
    event playerAttended(address player);

    address public owner;
    address[] private addressIndex;
    address public winner;
    uint initialNumber = 0;
    uint winnerIndex = 0;
    uint public pastBlockTime;

    struct lottery{
        uint index; // user index
        address owner; //lottery owner
        uint time; //time user attended
    }
    mapping(address => lottery) playerLottery;

    constructor() payable
    {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only admin can call this function");
        _;
    }

    //User attend lottery
    function attendLottery() public payable {
        bool canAttend = block.timestamp > playerLottery[msg.sender].time || playerLottery[msg.sender].time == 0 ;
        require(msg.value >= 2, "Require at least 2 wei to attend");
        require(canAttend,"Can attend 1 times per week");
        addressIndex.push(msg.sender);
        playerLottery[msg.sender].owner = msg.sender;
        playerLottery[msg.sender].index = addressIndex.length - 1;
        playerLottery[msg.sender].time = block.timestamp + 7 days;
    }

    //random winner index
    function randomWinner() public onlyOwner {
        require(addressIndex.length > 2, "Require more than 2 players");
        winnerIndex = uint(keccak256(abi.encodePacked(initialNumber++))) % addressIndex.length;
        winner = playerLottery[addressIndex[winnerIndex]].owner; //get winner
        emit winnerChosen(address(this).balance,winner);
        winner.call{value: address(this).balance}; //pay winner with this contract balance
        addressIndex = new address payable[](0); // reset lottery player pool
    }
    

    function getOwner() public view returns(address){
        return owner;
        }

    function getBalance() public view returns(uint){
        return (payable(address(this))).balance;
        }

    function getLottery() public view returns(lottery memory){
        return playerLottery[msg.sender];
    }

    function getIndex() public view onlyOwner returns(address[] memory){
        return addressIndex;
    }
}
