pragma solidity 0.4.24;

contract Vote {

    // structure
    struct candidator {
        string name;
        uint upVote;

    }

    // variable
    bool live;
    address owner;
    candidator[] public candidatorList; //candidator 구조체

    // mapping
    mapping(address => bool) Voted;

    // event
    event AddCandidator(string name);
    event UpVote(string candidator, uint upVote);
    event FinishVote(bool live);
    event Voting(address owner);

    // modifier
    modifier onlyOwner {
        require(msg.sender ==owner);
        _;
    }

    // constructor
    constructor() public {
        owner = msg.sender;
        live = true;

        emit Voting(owner);
    }

    // candidator
    function addCandidator(string _name) public onlyOwner{
        require(live == true);
        require(candidatorList.length < 5); //가스 절약 효과 (5명 이하)
        candidatorList.push(candidator(_name, 0));
        
        // emit event  이벤트를 발생 시킬 떈 emit을 먼저 적어줘야함
        emit AddCandidator(_name);
    }

    // voting
    function upVote(uint _indexOfCandidator) public { // 몇번 째 후보에 보팅 할건지
        require(live == true);
        require(_indexOfCandidator < candidatorList.length);
        require(Voted[msg.sender] == false);

        candidatorList[_indexOfCandidator].upVote++;

        // 이미 보팅을 했는지 확인하고 막아주기 솔리디티의 함수(sender의 주소 호출)
                Voted[msg.sender] = true;

        emit UpVote(candidatorList[_indexOfCandidator].name, candidatorList[_indexOfCandidator].upVote);
    }
    // finish vote.  contract를 만든 사람만 닫을 수 있게 ->modifier
    function finishVote() public onlyOwner{
        require(live == true);
        live = false;

        emit FinishVote(live);
    }
}