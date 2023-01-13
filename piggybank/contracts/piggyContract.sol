// SPDX-License-Identifier: MIT

pragma solidity = 0.8.17;

contract piggie{

    struct savingBox{
        address payable owner;
        string savingName;
        uint locktime;
        uint amountSaved;
        // uint[] boxId;
    }

    modifier onlyOwner(){
        require(msg.sender == users[msg.sender].owner, "you are not the owner");
        _;
    }


    mapping(address => savingBox) users;


    function createBox(uint _locktime, string memory _savingName) public {
        // uint boxCount = 0;
        address payable _accountOwner = payable(msg.sender);
        uint _unlockTime = block.timestamp + (86400 * _locktime);

        users[msg.sender].owner = _accountOwner;
        users[msg.sender].savingName = _savingName;
        users[msg.sender].locktime = _unlockTime;
        // boxCount ++;
        // users[msg.sender].boxId.push(boxCount);
    }

    function depostiFunds() public payable onlyOwner{
        require(msg.value >= 1 ether, "Amount too small"); // checks if value to save is upto 1 ether
        require(msg.value <= msg.sender.balance, "insufficient funds"); //check if user has ether to save
        require(block.timestamp <= users[msg.sender].locktime, "you can't deposit anymore"); //if time elapsed, you can't deposit again
        msg.sender.balance - msg.value;
        users[msg.sender].amountSaved += msg.value;

    }

    function withdraw(uint _amount) external payable onlyOwner{
        require(block.timestamp >= users[msg.sender].locktime, "You can't withdraw yet");
        require(_amount <= users[msg.sender].amountSaved, "You can't withdraw more than what you deposited");
        users[msg.sender].amountSaved -= _amount;
        payable(msg.sender).transfer(_amount);

    }

    function boxBalance() external onlyOwner view returns(uint balance) {
        balance = users[msg.sender].amountSaved;
    }

    function numberDays() external onlyOwner view returns(uint) {
        return (users[msg.sender].locktime);
    }

    function currenTime() external view returns(uint){
        return(block.timestamp);
    }

}