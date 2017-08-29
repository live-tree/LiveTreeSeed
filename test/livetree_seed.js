var LTS = artifacts.require("./LTS.sol");
const icoStartBlock = 0;
const icoEndBlock = 10;
contract('LTS - LiveTree Seed', function(accounts) {
it("Test for starting ICO", function(done) {
	LTS.deployed().then(function(instance) {
	    return instance.startSeedSale.call();
	}).then(function(status) {
        assert.equal(status, true, "Not started seed sale.");
    });
    done();
});
it("Create 2000 000 000 seed in the owner account", function(done) {
    LTS.deployed().then(function(instance) {
        return instance.balanceOf.call(accounts[0]);
    }).then(function(balance) {
        assert.equal(web3.toWei(2000000000, 'ether'), web3.toWei(balance.valueOf(), 'ether'), "2000000000 wasn't in the first account");
    });
    done();
});
it('Should transfer seed correctly', function(done){
    var seed;
    var amount = 10;
    var account_one = accounts[0];
    var account_two = accounts[1];
    var acc_one_before;
    var acc_one_after;
    var acc_two_before;
    var acc_two_after;
    LTS.deployed().then(function(instance){
         seed = instance; 
         return seed.balanceOf.call(account_one);
    }).then(function(balanceOne) {
         acc_one_before = balanceOne.toNumber();
         return seed.balanceOf.call(account_two);
    }).then(function(balanceTwo) {
         acc_two_before = balanceTwo.toNumber();
         return seed.transfer(account_two, amount, {from: account_one});
    }).then(function() {
         return seed.balanceOf.call(account_one);
    }).then(function(balanceOne){
         acc_one_after = balanceOne.toNumber();
         return seed.balanceOf.call(account_two);
    }).then(function(balanceTwo){
         acc_two_after = balanceTwo.toNumber();
         assert.equal(acc_one_after, acc_one_before - amount, "Seed transfer works wrong!");
         assert.equal(acc_two_after, acc_two_before + amount, "Seed transfer works wrong!");
        });
        done();
    });
	it('Should allocate 10%(200000000) seed out of total raised seed to share amoung decided devisions.', function(done){
	    var seed;
	    LTS.deployed().then(function(instance){
	        seed = instance; 
	        return seed.allocateSeed.call();
	    }).then(function(totalAlocation) {
	        assert.equal(200000000, totalAlocation.toNumber(), "Seed allocation amount is wrong!");
	    });
       done();
    });
    it('Should allocate 8.25%(16500000) of seed to presale out of allocated all seed.', function(done){
	    var seed;
	    var allocationSeed;
    	var presaleAccount = accounts[1];
	    LTS.deployed().then(function(instance){
	        seed = instance; 
	        return seed.allocateSeed.call();
	    }).then(function(seeds) {
	    	allocationSeed = seeds.toNumber();
	    	return seed.allocateToPreSales.call(presaleAccount, allocationSeed);
	    }).then(function(presaleAccountBalance) {
	        assert.equal(16500000, presaleAccountBalance.toNumber(), "Presale account seed allocation amount is wrong!");
	    });
       done();
    });
    it('Should allocate 53.75%(107500000) of seed to sale out of allocated all seed.', function(done){
	    var seed;
	    var allocationSeed;
    	var saleAccount = accounts[1];
	    LTS.deployed().then(function(instance){
	        seed = instance; 
	        return seed.allocateSeed.call();
	    }).then(function(seeds) {
	    	allocationSeed = seeds.toNumber();
	    	return seed.allocateToSales.call(saleAccount, allocationSeed);
	    }).then(function(saleAccountBalance) {
	        assert.equal(107500000, saleAccountBalance.toNumber(), "Sale account seed allocation amount is wrong!");
	    });
       done();
    });
    it('Should allocate 15%(30000000) of seed to later funding reserve out of allocated all seed.', function(done){
	    var seed;
	    var allocationSeed;
    	var laterFundingReserveAccount = accounts[1];
	    LTS.deployed().then(function(instance){
	        seed = instance; 
	        return seed.allocateSeed.call();
	    }).then(function(seeds) {
	    	allocationSeed = seeds.toNumber();
	    	return seed.allocateToLaterFunding.call(laterFundingReserveAccount, allocationSeed);
	    }).then(function(laterFundingReserveAccountBalance) {
	        assert.equal(30000000, laterFundingReserveAccountBalance.toNumber(), "Later funding reserve account seed allocation amount is wrong!");
	    });
       done();
    });
    it('Should allocate 5%(10000000) of seed to open-source developers reserve out of allocated all seed.', function(done){
	    var seed;
	    var allocationSeed;
    	var openSourceDevelopersAccount = accounts[1];
	    LTS.deployed().then(function(instance){
	        seed = instance; 
	        return seed.allocateSeed.call();
	    }).then(function(seeds) {
	    	allocationSeed = seeds.toNumber();
	    	return seed.allocateToOpenSourceDevelopers.call(openSourceDevelopersAccount, allocationSeed);
	    }).then(function(openSourceDevelopersAccountBalance) {
	        assert.equal(10000000, openSourceDevelopersAccountBalance.toNumber(), "Open-source developers reserve account seed allocation amount is wrong!");
	    });
       done();
    });
    it('Should allocate 3%(6000000) of seed to marketing reserve out of allocated all seed.', function(done){
	    var seed;
	    var allocationSeed;
    	var marketingAccount = accounts[1];
	    LTS.deployed().then(function(instance){
	        seed = instance; 
	        return seed.allocateSeed.call();
	    }).then(function(seeds) {
	    	allocationSeed = seeds.toNumber();
	    	return seed.allocateToMarketing.call(marketingAccount, allocationSeed);
	    }).then(function(marketingAccountBalance) {
	        assert.equal(6000000, marketingAccountBalance.toNumber(), "Marketing reserve account seed allocation amount is wrong!");
	    });
       done();
    });
    it('Should allocate 5%(10000000) of seed to brancher promoters reserve out of allocated all seed.', function(done){
	    var seed;
	    var allocationSeed;
    	var brancherPromotersAccount = accounts[2];
	    LTS.deployed().then(function(instance){
	        seed = instance; 
	        return seed.allocateSeed.call();
	    }).then(function(seeds) {
	    	allocationSeed = seeds.toNumber();
	    	return seed.allocateToBrancherPromoters.call(brancherPromotersAccount, allocationSeed);
	    }).then(function(brancherPromotersAccountBalance) {
	        assert.equal(10000000, brancherPromotersAccountBalance.toNumber(), "Brancher promoters reserve account seed allocation amount is wrong!");
	    });
       done();
    });
    it('Should allocate 10%(20000000) of seed to founding team reserve out of allocated all seed.', function(done){
	    var seed;
	    var allocationSeed;
    	var foundingTeamAccount = accounts[3];
	    LTS.deployed().then(function(instance){
	        seed = instance; 
	        return seed.allocateSeed.call();
	    }).then(function(seeds) {
	    	allocationSeed = seeds.toNumber();
	    	return seed.allocateToFoundingTeam.call(foundingTeamAccount, allocationSeed);
	    }).then(function(foundingTeamAccountAccountBalance) {
	        assert.equal(20000000, foundingTeamAccountAccountBalance.toNumber(), "Founding team reserve account seed allocation amount is wrong!");
	    });
       done();
    });
});
