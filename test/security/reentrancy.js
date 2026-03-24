const { expect } = require("chai");
const { ethers } = require("hardhat");

it("Should NOT be exploitable after fix", async function () {

  const [owner, attackerAcc] = await ethers.getSigners();

  const Vault = await ethers.getContractFactory("FixedVault");
  const vault = await Vault.deploy();
  await vault.waitForDeployment();

  await vault.deposit({ value: ethers.parseEther("5") });

  const Attacker = await ethers.getContractFactory("Attacker");
  const attacker = await Attacker.connect(attackerAcc).deploy(await vault.getAddress());
  await attacker.waitForDeployment();

  await expect(
    attacker.connect(attackerAcc).attack({
      value: ethers.parseEther("1")
    })
  ).to.be.reverted;
});