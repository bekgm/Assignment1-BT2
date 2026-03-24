const { ethers, upgrades } = require("hardhat");

async function main() {

  const LogicV1 = await ethers.getContractFactory("LogicV1");
  const proxy = await upgrades.deployProxy(LogicV1, [], {
    initializer: "initialize",
  });

  await proxy.waitForDeployment();

  console.log("Proxy deployed to:", await proxy.getAddress());

  await proxy.increment();
  await proxy.increment();

  console.log("Counter (V1):", (await proxy.get()).toString());

  const LogicV2 = await ethers.getContractFactory("LogicV2");

  const upgraded = await upgrades.upgradeProxy(
    await proxy.getAddress(),
    LogicV2
  );

  console.log("Upgraded!");

  console.log("Counter after upgrade:", (await upgraded.get()).toString());

  await upgraded.decrement();
  console.log("After decrement:", (await upgraded.get()).toString());

  await upgraded.reset();
  console.log("After reset:", (await upgraded.get()).toString());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});