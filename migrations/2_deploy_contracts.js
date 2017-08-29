var LTS = artifacts.require("./LTS.sol");
var LTSPresale = artifacts.require("./LTSPresale.sol");


module.exports = function(deployer) {
	const tokenAmount = 2000000000;
	const totalPresaleAmount = 16500000;
    deployer.deploy(LTS, tokenAmount);
    deployer.deploy(LTSPresale, totalPresaleAmount);
};
