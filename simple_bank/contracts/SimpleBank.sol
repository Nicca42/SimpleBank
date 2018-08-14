pragma solidity ^0.4.13;
contract SimpleBank {

    private mapping (address => uint) balances;
    public mapping (address => bool) enrolled;
    public address owner;

    event LogEnrolled(address accountAddress);
    event LogDepositMade(address accountAddress, uint amount);
    event LogWithdrawal(address accountAddress, uint withdrawAmount, uint newBalance);

    constructor() {
        owner = msg.sender;
    }

    function enroll(address customer) public returns (bool){
        enrolled[customer] = true;
        emit LogEnrolled(customer);
    }

    function deposit(address user) public payable returns (uint) {
        balences[user] += msg.value;
        emit LogDepositMade(user, msg.value);
        return balences[user];
    }

    function withdraw(uint withdrawAmount, address user) public payable returns (uint) {
        if(balances[user] >= withdrawAmount) { 
            balances[user] -= withdrawAmount;
            balances[user].send(withdrawAmount);
        } else {
            return balances[user];
        }
    }

    function balance() public view returns (uint) {
        returns balances[msg.sender];
    }

    function() {
        revert();
    }
}
