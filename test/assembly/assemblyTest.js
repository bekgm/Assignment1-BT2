const { ethers } = require("hardhat");

describe("Assembly vs Solidity", function () {

  it("Compare gas usage", async function () {

    const Assembly = await ethers.getContractFactory("Assembly");
    const asm = await Assembly.deploy();
    await asm.waitForDeployment();

    const Normal = await ethers.getContractFactory("Normal");
    const normal = await Normal.deploy();
    await normal.waitForDeployment();

    // setValue comparison
    let tx1 = await normal.setValue(42);
    let r1 = await tx1.wait();

    let tx2 = await asm.setValue(42);
    let r2 = await tx2.wait();

    console.log("Normal setValue gas:", r1.gasUsed.toString());
    console.log("Assembly setValue gas:", r2.gasUsed.toString());

    // power of two check
    let tx3 = await normal.isPowerOfTwo(16);
    let tx4 = await asm.isPowerOfTwo(16);

    console.log("Normal result:", tx3);
    console.log("Assembly result:", tx4);
  });

});