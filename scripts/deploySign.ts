import { ethers } from "hardhat";

const main = async () => {
  const Signer = await ethers.getContractFactory("WhoIsTheWinner");
  const sign = await Signer.deploy();
  await sign.deployed();
  console.log("Signer deployed to:", sign.address);
};

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
