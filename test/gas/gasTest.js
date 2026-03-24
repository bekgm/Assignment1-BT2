const { ethers } = require("hardhat");

describe("Gas Optimization", function () {

  it("Compare gas usage", async function () {

    const Unoptimized = await ethers.getContractFactory("Unoptimized");
    const unopt = await Unoptimized.deploy();
    await unopt.waitForDeployment();

    const Optimized = await ethers.getContractFactory("Optimized");
    const opt = await Optimized.deploy();
    await opt.waitForDeployment();

    const nums = [1,2,3,4,5,6,7,8,9,10];

    let tx1 = await unopt.addNumbers(nums);
    let r1 = await tx1.wait();

    let tx2 = await opt.addNumbers(nums);
    let r2 = await tx2.wait();

    console.log("Unoptimized gas:", r1.gasUsed.toString());
    console.log("Optimized gas:", r2.gasUsed.toString());
  });

});