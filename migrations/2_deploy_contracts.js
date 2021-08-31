var FIT = artifacts.require("FIT");
var Log = artifacts.require("Log");
var Para = artifacts.require("Log");
module.exports = function(deployer) {
  let fitId
  let fileData
  let logId
  let pubkey
  let g
  let u
  let pairing
  let chal
  let k1
  let k2
  let myu
  let gamma
  let result
  deployer.deploy(FIT, fitId, fileData);
  deployer.deploy(Log, logId, pubkey, chal, k1, k2, myu, gamma, result)
  deployer.deploy(Para,g, u, pairing)
};