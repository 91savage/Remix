pragma solidity 0.4.24;

contract Vote {

    // structure
    struct candidator {
        string name;
        uint upVote;

    }

    // variable
    candidator[] public candidatorList; //candidator 구조체

    // mapping

    // event
    event AddCandidator(string name);
    event UpVote(string candidator, uint upVote);

    // modifier

    // constructor kk s

    // candidator
    function addCandidator(string _name) public {
        require(candidatorList.length < 5); //가스 절약 효과 (5명 이하)
        candidatorList.push(candidator(_name, 0));
        
        // emit event  이벤트를 발생 시킬 떈 emit을 먼저 적어줘야함
        emit AddCandidator(_name);
    }

    // voting
    function upVote(uint _indexOfCandidator) public { // 몇번 째 후보에 보팅 할건지
        require(_indexOfCandidator < candidatorList.length);
        candidatorList[_indexOfCandidator].upVote++;

        emit UpVote(candidatorList[_indexOfCandidator].name, candidatorList[_indexOfCandidator].upVote);
    }
    // finish vote
    function finishVote() public {

    }
}