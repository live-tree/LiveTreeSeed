pragma solidity ^0.4.11;

contract LTSInterface
{

    /* Constants */
    string public name = "LiveTree Seed";
    string public symbol = "LTS";
    uint public decimals = 18;

    uint seedAllocation = 0;
    uint preSalesSeeds = 0;
    uint salesSeeds = 0;
    uint laterFundingReserveSeeds = 0;
    uint openSourceDevelopersReserveSeeds = 0;
    uint reserveForMarketingSeeds = 0;
    uint reserveForBrancherPromotersSeeds = 0;
    uint reserveForFoundingTeamSeeds = 0;

    // flags whether ICO is afoot.
    bool fundingMode;
    
    // Funding amount in ether 
    //0.00004 ether = 0.01 USD
    uint public constant seedPrice  = 0.00004 ether;
}