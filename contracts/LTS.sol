pragma solidity ^0.4.11;

import "zeppelin-solidity/contracts/token/MintableToken.sol";
import "./LTSInterface.sol";
import "./Addresses.sol";

contract LTS is MintableToken, LTSInterface {

    Addresses addresses = new Addresses();
    
    /* Modifiers */
    modifier isNotFundable() {
        assert (fundingMode);
        _;
    }

    modifier isFundable() {
        assert (!fundingMode);
        _;
    }

    /* Functions */
    function LTS(uint256 _amount) {
        owner = msg.sender;
        mint(owner, _amount);
        // get seed balance from owner address
        seedAllocation = _amount;
        fundingMode = false;
    }


    /* Functions Getters */
    //@notice Function to get the current funding status.
    function fundingStatus() external constant returns (bool){
      return fundingMode;
    }

    /* Functions Public */    
    //@notice Function to start the contract.
    //@notice Can be called only by the owner
    function startSeedSale() onlyOwner external returns (bool){
      fundingMode = true;
      return fundingMode;
    }

    function allocateSeed() external returns (uint) {
        // Calculate 10% of seed for allocation from seedAllocation
        uint availableSeedForAllocation = calculatePortion(seedAllocation, 10);

        allocateToPreSales(addresses.preSalesVault(), availableSeedForAllocation);
        allocateToSales(addresses.salesVault(), availableSeedForAllocation);
        allocateToLaterFunding(addresses.laterFundingReserveVault(), availableSeedForAllocation);
        allocateToOpenSourceDevelopers(addresses.openSourceDevelopersReserveVault(), availableSeedForAllocation);
        allocateToMarketing(addresses.reserveForMarketingVault(), availableSeedForAllocation);
        allocateToBrancherPromoters(addresses.reserveForBrancherPromotersVault(), availableSeedForAllocation);
        allocateToFoundingTeam(addresses.reserveForFoundingTeamVault(), availableSeedForAllocation);
        return availableSeedForAllocation;
    }

    function allocateToPreSales(address _preSales, uint availableSeedForAllocation) returns (uint) {
        // Calculate 8.25% of seed for presales from allocated seed
        preSalesSeeds = calculatePortion(availableSeedForAllocation, 825);
        preSalesSeeds = preSalesSeeds / 100;
        transfer(_preSales, preSalesSeeds);
        return balanceOf(_preSales);
    }

    function allocateToSales(address _sales, uint availableSeedForAllocation) returns (uint) {
        // Calculate 53.75% of seed for sales from allocated seed
        salesSeeds = calculatePortion(availableSeedForAllocation, 5375);
        salesSeeds = salesSeeds / 100;
        transfer(_sales, salesSeeds);
        return balanceOf(_sales);
    }

    function allocateToLaterFunding(address _laterFunding, uint availableSeedForAllocation) returns (uint) {
        // Calculate 15% of seed for Later funding reserve from allocated seed
        laterFundingReserveSeeds = calculatePortion(availableSeedForAllocation, 15);

        transfer(_laterFunding, laterFundingReserveSeeds);
        return balanceOf(_laterFunding);
    }

    function allocateToOpenSourceDevelopers(address _openSourceDeveloper, uint availableSeedForAllocation) returns (uint) {
        // Calculate 5% of seed for Open-source developers reserve from allocated seed
        openSourceDevelopersReserveSeeds = calculatePortion(availableSeedForAllocation, 5);

        transfer(_openSourceDeveloper, openSourceDevelopersReserveSeeds);
        return balanceOf(_openSourceDeveloper);
    }

    function allocateToMarketing(address _marketing, uint availableSeedForAllocation) returns (uint) {
        // Calculate 3% of seed Reserve for marketing from allocated seed
        reserveForMarketingSeeds = calculatePortion(availableSeedForAllocation, 3);

        transfer(_marketing, reserveForMarketingSeeds);
        return balanceOf(_marketing);
    }

    function allocateToBrancherPromoters(address _brancherPromoters, uint availableSeedForAllocation) returns (uint) {
        // Calculate 5% of seed Reserve for brancher promoters from allocated seed
        reserveForBrancherPromotersSeeds = calculatePortion(availableSeedForAllocation, 5);

        transfer(_brancherPromoters, reserveForBrancherPromotersSeeds);
        return balanceOf(_brancherPromoters);
    }

    function allocateToFoundingTeam(address _foundingTeam, uint availableSeedForAllocation) returns (uint) {
        // Calculate 10% of seed Reserve for founding team from allocated seed
        reserveForFoundingTeamSeeds = calculatePortion(availableSeedForAllocation, 10);

        transfer(_foundingTeam, reserveForFoundingTeamSeeds);
        return balanceOf(_foundingTeam);
    }

    //@notice Finalize the ICO, send team allocation tokens
    //@notice send any remaining balance to the MultisigWallet
    //@notice unsold tokens will be sent to icedwallet
    function finalize() isFundable onlyOwner external {
      // switch funding mode off
      fundingMode = false;
    }

    /* Functions Internal */

    // Internal functions handle this contract's logic.
	function calculatePortion(uint totalseed, uint portion) returns (uint){
		return (totalseed *  portion) / 100;
	}

    //@notice Function to pause the contract.
    //@notice Can be called only when funding is active and only by the owner
    function pauseSeedSale() onlyOwner isFundable external returns (bool){
      fundingMode = false;
      return !fundingMode;
    }
}