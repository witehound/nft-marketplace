import { ethers } from "hardhat";

async function main() {


  const Lock = await ethers.getContractFactory("Lock");
  const lock = await Lock.deploy();

  await lock.deployed();

  console.log(`Lock with 1 ETH and unlock timestamp  deployed to ${lock.address}`);
}


main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
