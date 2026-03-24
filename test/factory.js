const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Factory", function () {

  let factory;

  beforeEach(async function () {
    const Factory = await ethers.getContractFactory("Factory");
    factory = await Factory.deploy();
    await factory.waitForDeployment();
  });

  it("CREATE deployment", async function () {

    const tx = await factory.createChild("Test1");
    const receipt = await tx.wait();

    console.log("CREATE gas:", receipt.gasUsed.toString());

    const contracts = await factory.getDeployedContracts();

    console.log("Child1 address:", contracts[0]);  
    console.log("All deployed contracts:", contracts);

    expect(contracts.length).to.equal(1);
  });

  it("CREATE2 deployment", async function () {

    const salt = ethers.id("salt1");

    const tx = await factory.createChild2("Test2", salt);
    const receipt = await tx.wait();

    console.log("CREATE2 gas:", receipt.gasUsed.toString());

    const contracts = await factory.getDeployedContracts();

    console.log("Child2 address:", contracts[0]);  
    console.log("All deployed contracts:", contracts); 

    expect(contracts.length).to.equal(1);
  });

});