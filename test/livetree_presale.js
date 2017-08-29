var LTSPresale = artifacts.require("./LTSPresale.sol");
contract('LTS - LiveTree Presale', function(accounts) {
	it("Test for totalPresaleSupply", function(done) {
		var presaleInstance;
		LTSPresale.deployed().then(function(instance) {
			presaleInstance = instance;
		    return presaleInstance.getTotalPresaleSupply.call();
		}).then(function(totalPresaleSupply) {
	        assert.equal(16500000, totalPresaleSupply.toNumber(), "Presale supply is not as per expectation.");
	    });
	    done();
	});

	it("Test for presale seed purchase in first week of launch(10% Bonus).Purchase of seed is 2000 and expecting to add 2200 in purchaser account.", function(done) {
		var presaleInstance;
		LTSPresale.deployed().then(function(instance) {
			presaleInstance = instance;
		    return presaleInstance.getTotalPresaleSupply.call();
		}).then(function(totalPresaleSupply) {
	        return presaleInstance.purchase.call(2000, accounts[2])
	    }).then(function(purchaserBalance) {
	        assert.equal(2200, purchaserBalance.toNumber(), "Purchaser balance after presale seed purchase is not as per expectations.");
	    });
	    done();
  });
});
