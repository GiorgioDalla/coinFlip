import { ethers } from "hardhat";

const main = async () => { 
    const Delegation = await ethers.getContractFactory("AttackDelegate");
    const delegation = await Delegation.deploy(
      "0xc9df37f656761720119eF0FAe48dAA6688e9fC84"
    );
    await delegation.deployed();
    await delegation.attack();
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
