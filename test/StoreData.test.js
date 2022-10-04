const { BigNumber } = require("@ethersproject/bignumber");
const chai = require("chai");
const { expect } = chai;
const { ethers, upgrades } = require("hardhat");
const { solidity } = require("ethereum-waffle");
chai.use(solidity);

let owner, addr1, addr2, addr3, addr4, StoreData, storeData;

describe("Store Data in Assembly Language", () => {
  beforeEach(async () => {
    accounts = await ethers.getSigners();
    [owner, addr1, addr2, addr3, addr4, _] = accounts;

    StoreData = await ethers.getContractFactory("StoreData");
    storeData = await StoreData.deploy();
  });

  describe("Set Data", async function () {
    it("to set new value & get data", async function () {
      await storeData.connect(addr1).setData(1000);
      console.log(await storeData.connect(addr1).getData());
    });
  });
});
