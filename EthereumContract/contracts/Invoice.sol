pragma solidity ^0.4.2;

import "./MetaCoin.sol";

contract Invoice{

  address public owner;
  uint amount;

  MetaCoin metaCoin;

  function Invoice(){
    owner = msg.sender;
  }

  function setAmount(uint invoiceAmount) returns(bool sufficient){
    //if(stringsEqual(msg.sender,owner)){
        amount = invoiceAmount;
        return true;
    //}
  }

  modifier onlyOwner() {
      if (msg.sender != owner) throw;
      _;
  }

  function transferOwnership(address newOwner) onlyOwner {
      owner = newOwner;
  }

  function transferFund(address financiery, uint defactorPercentage){
      uint transferAmount = (amount * defactorPercentage) / 100;
      metaCoin.sendCoin(owner, transferAmount);
      transferOwnership(financiery);
  }

  function getBalance(address addr) returns(uint) {
    return metaCoin.getBalance(addr);
  }

  function stringsEqual(string storage _a, string memory _b) internal returns (bool) {
		bytes storage a = bytes(_a);
		bytes memory b = bytes(_b);
		if (a.length != b.length)
			return false;
		// @todo unroll this loop
		for (uint i = 0; i < a.length; i ++)
			if (a[i] != b[i])
				return false;
		return true;
	}
}
