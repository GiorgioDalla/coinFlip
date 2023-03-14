import { ethers } from "hardhat";

const main = async () => {
    const OpenGate = await ethers.getContractFactory("OpenTheGate");
    const openGate = await OpenGate.deploy();
    await openGate.deployed();
    await openGate.unlock("0xBd4dfAcb2bFDcECC3CC474899F3A6F6c9C4401fe");

};

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
