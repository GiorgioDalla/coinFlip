// Set up an ethers contract, representing our deployed Box instance

import { ethers } from "hardhat";

const main = async () => {
  const address = "0x9240670dbd6476e6a32055E52A0b0756abd26fd2"; // this is the coinflip contract address
  const Coinflip = await ethers.getContractFactory("CoinFlip");
  const coinflip = await Coinflip.attach(address);
  const attackCoin = await ethers.getContractFactory("AttackCoin");
  const AttackCoin = await attackCoin.deploy(address);
  await AttackCoin.deployed();
  console.log("AttackCoin deployed to:", AttackCoin.address);
  const attacking = await AttackCoin.attack();
  await attacking.wait(1);
  console.log("Attacking");
};

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
