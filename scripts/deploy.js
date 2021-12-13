
const hre = require("hardhat");

async function main() {
  
  const Greeter = await hre.ethers.getContractFactory("Greeter");
  const greeter = await Greeter.deploy("Hello, Hardhat!");

  await greeter.deployed();

  console.log("Greeter deployed to:", greeter.address);

  const myERC20 = await ethers.getContractFactory("ERC20");
  const Token = await myERC20.deploy('WildrToken', 'WRT', 18, 1000000);

  await Token.deployed();

  console.log("WRT deployed to:", Token.address);

  
}


main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
