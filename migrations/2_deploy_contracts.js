var FIT = artifacts.require("FileIndexTable");
var Log = artifacts.require("Log");
var Para = artifacts.require("Log");
module.exports = function(deployer) {

  // システムマネジャがコントラクトをデプロイする際にTPA,SPのイーサリアムアドレスを登録する．
  const tpaAddress = 0x5eA41A9Fc533fbBC8f6021d376078DF144907aAe
  const spAddress = 0x5eA41A9Fc533fbBC8f6021d376078DF144907aAe
  // Para等の最初から登録しておくデータもコントラクト起動時に登録することができる．

  deployer.deploy(FIT, spAddress);
  deployer.deploy(Log, tpaAddress)
  deployer.deploy(Para)
  
};