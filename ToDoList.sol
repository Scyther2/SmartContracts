// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

struct List{
    string task;
    bool status;
}

contract ToDo{

    List[] public arr;

    function insert(string memory _task) public{
        arr.push(List({
            task: _task,
            status: false
        }));
    }

    function update(uint _index, string memory _task) public{
        arr[_index].task=_task;
    }

    function ChangeStatus(uint _index) public{
        arr[_index].status= !arr[_index].status;
    }

    function get(uint _index) public view returns(string memory,bool){
        List memory temp=arr[_index];
        return (temp.task,temp.status);
    }
}
