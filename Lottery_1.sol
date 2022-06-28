// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract Lottery{

    address public manager;
    address payable[] public players;

    constructor ()
    {
        manager=msg.sender;
    }

    receive() external payable
    {
        require(msg.value == 1 ether);
        players.push(payable(msg.sender));
    }

    function random() public view returns(uint)
    {
        return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,players.length)));
    }

    function getbalance() public view returns (uint)
    {
        require(msg.sender==manager);
        return address(this).balance;
    }

    function TransferToWinner() public
    {
        require(msg.sender==manager);
        require(players.length>=5);
        uint r=random();
        address payable finaladd;
        uint winner=r%players.length;
        finaladd=players[winner];
        finaladd.transfer(getbalance());
        players=new address payable[](0);
    }

}
