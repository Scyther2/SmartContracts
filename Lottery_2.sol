// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract Lottery_2{
    address public manager;
    address payable[] public players;
    mapping (address=>uint) public data;
    address payable[] public participants;

    constructor(){
        manager=msg.sender;
    }

    receive() external payable
    {
        if(data[msg.sender]==0)
        {
            players.push(payable(msg.sender));
        }
        data[msg.sender]+=msg.value;
    }

    function getbalance() public view returns (uint)
    {
        require(msg.sender==manager);
        return address(this).balance;
    }

    function TicketAllocation() public
    {
        for(uint i=0;i<players.length;i++)
        {
            uint temp=data[players[i]];
            while(temp>=1000000000000000000)
            {
                participants.push(payable(players[i]));
                temp-=1000000000000000000;
                data[players[i]]-=1000000000000000000;
            }
            
        }
    }

    function random() public view returns(uint)
    {
        return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,players.length)));
    }

    function TransferToWinner() public
    {
        require(msg.sender==manager);
        require(participants.length>=5);
        uint r=random();
        address payable finaladd;
        uint winner=r%participants.length;
        finaladd=participants[winner];
        finaladd.transfer(getbalance());
        players=new address payable[](0);
        participants=new address payable[](0);
    }



}
