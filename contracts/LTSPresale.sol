pragma solidity ^0.4.11;

import "zeppelin-solidity/contracts/math/SafeMath.sol";
import 'zeppelin-solidity/contracts/ownership/Ownable.sol';
import 'zeppelin-solidity/contracts/lifecycle/Pausable.sol';

contract LTSPresale is Pausable {
  using SafeMath for uint;
  uint totalPresaleSupply = 0; //16500000

  address LTSTokenFactory;
  uint totalUsedTokens;
  mapping(address => uint) balances;
  //Sale Period
  address[] purchasers;
  uint public salePeriod;
  uint public presaleStart;

  function LTSPresale(uint _totalPresaleSupply) {
    totalPresaleSupply = _totalPresaleSupply;
    //presale is open for
    presaleStart = now;
    salePeriod = now.add(4 weeks);
    totalUsedTokens = 0;
  }

  function purchase(uint numberofseed, address _purchaser) external whenNotPaused payable returns (uint){
    if(now > salePeriod) require;
    if(totalUsedTokens >= totalPresaleSupply) require;
    
    if(numberofseed < 1) require;

    uint bonusSeed = 0;
    if(now <= presaleStart + 7 days){
      //10% bonus seed on first week purchase
      bonusSeed = (numberofseed *  10) / 100;
    } else if(now <= presaleStart + 2 weeks && now > presaleStart + 7 days){
      //5% bonus seed on second week purchase
      bonusSeed = (numberofseed *  5) / 100;
    } else if(now <= presaleStart + 3 weeks && now > presaleStart + 2 weeks){
      //2% bonus seed on third week purchase
      bonusSeed = (numberofseed *  2) / 100;
    }

    uint numberofseedWithBonus = numberofseed + bonusSeed;

    totalUsedTokens = totalUsedTokens.add(numberofseedWithBonus);
    if (totalUsedTokens > totalPresaleSupply) require;

   
    purchasers.push(_purchaser);
    balances[_purchaser] = balances[_purchaser].add(numberofseedWithBonus);
    return balances[_purchaser];
  }

  function getTotalPresaleSupply() external constant returns (uint256) {
    return totalPresaleSupply;
  }

  //@notice Function reports the number of tokens available for sale
  function numberOfTokensLeft() constant returns (uint256) {
    uint tokensAvailableForSale = totalPresaleSupply.sub(totalUsedTokens);
    return tokensAvailableForSale;
  }

  function finalize() external whenNotPaused onlyOwner {
    if(totalUsedTokens < totalPresaleSupply) require;

    LTSTokenFactory.transfer(this.balance);
    paused = true;
  }

  function balanceOf(address owner) constant returns (uint) {
    return balances[owner];
  }

  function getPurchasers() onlyOwner whenPaused external returns (address[]) {
    return purchasers;
  }

  function numOfPurchasers() onlyOwner external constant returns (uint) {
    return purchasers.length;
  }

  function unpause() onlyOwner whenPaused returns (bool) {
    salePeriod = now.add(50 hours);
    super.unpause();
  }
}