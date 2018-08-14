pragma solidity ^0.4.13;
contract SimpleBank {

    mapping (address => uint) private balances;
    mapping (address => bool) public enrolled;
    address public owner;

    event LogEnrolled(address accountAddress);
    event LogDepositMade(address accountAddress, uint amount);
    event LogWithdrawal(address accountAddress, uint withdrawAmount, uint newBalance);

    constructor() public {
        owner = msg.sender;
    }

    function enroll() public returns (bool){
        enrolled[msg.sender] = true;
        emit LogEnrolled(msg.sender);
    }

    function deposit() public payable returns (uint) {
        balances[msg.sender] += msg.value;
        emit LogDepositMade(msg.sender, msg.value);
        return balances[msg.sender];
    }

    function withdraw(uint withdrawAmount) public payable returns (uint) {
        address user = msg.sender;
        if(balances[user] >= withdrawAmount) { 
            balances[user] -= withdrawAmount;
            user.transfer(withdrawAmount);
            emit LogWithdrawal(user, withdrawAmount, balances[user]);
        } else {
            return balances[user];
        }
    }

    function balance() public view returns (uint) {
        return balances[msg.sender];
    }

    function() {
        revert();
    }
}
