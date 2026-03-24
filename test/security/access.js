const { expect } = require("chai");
const { ethers } = require("hardhat");

it("Should prevent unauthorized access", async function () {

  const [owner, attacker] = await ethers.getSigners();

  const Contract = await ethers.getContractFactory("FixedAccess");
  const c = await Contract.deploy();
  await c.waitForDeployment();

  await expect(
    c.connect(attacker).withdraw()
  ).to.be.reverted;
});