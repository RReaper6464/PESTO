import { ethers } from "hardhat";
import * as dotenv from "dotenv";
dotenv.config();

async function main() {
  const { PRIVATE_KEY, ALCHEMY_API_URL } = process.env;

  // Connect to Ethereum network
  const provider = new ethers.providers.JsonRpcProvider(ALCHEMY_API_URL);
  const wallet = new ethers.Wallet(PRIVATE_KEY, provider);

  // Deploy NFT contract
  const NFT = await ethers.getContractFactory("PestoPenguins", wallet);
  const nft = await NFT.deploy("https://your-metadata-base-url.com/"); // Replace with your metadata base URL

  console.log("NFT Contract deployed to:", nft.address);
}

// Run the deploy script
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
