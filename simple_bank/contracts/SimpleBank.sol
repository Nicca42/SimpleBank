pragma solidity ^0.4.13;
contract SimpleBank {

    mapping (address => uint) private balances;
    mapping (address => bool) public enrolled;
    address public owner;

    event LogEnrolled(address accountAddress);
    event LogDepositMade(address accountAddress, uint amount);
    event LogWithdrawal(address accountAddress, uint withdrawAmount, uint newBalance);

    public constructor() {
        owner = msg.sender;
    }

    function enroll(address customer) public returns (bool){
        enrolled[customer] = true;
        emit LogEnrolled(customer);
    }

    function deposit(address user) public payable returns (uint) {
        balances[user] += msg.value;
        emit LogDepositMade(user, msg.value);
        return balances[user];
    }

    function withdraw(uint withdrawAmount, address user) public payable returns (uint) {
        if(balances[user] >= withdrawAmount) { 
            balances[user] -= withdrawAmount;
            user.transfer(withdrawAmount);
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
