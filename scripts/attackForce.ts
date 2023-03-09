import { ethers } from "hardhat";

const main = async () => {
  const Selfdestruct = await ethers.getContractFactory("SelfDestructor");
  const selfdestruct = await Selfdestruct.deploy();
    await selfdestruct.deployed();
    
  await selfdestruct.destroy("0xA01F28393d67CA815953ebDdB8dEa0A22188485C");
};

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
