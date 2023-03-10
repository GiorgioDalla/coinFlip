import { ethers } from "hardhat";

const main = async () => {


    const Elevator = await ethers.getContractFactory("AttackElevator");
    const elevator = await Elevator.deploy('0x6F8F14E31c91bA48Fa894bCDFae9197a8c369D1f')
    await elevator.deployed();
    elevator.hack()
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
