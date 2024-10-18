// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract PestoPenguins is ERC721Enumerable, Ownable {
    uint256 public constant MAX_SUPPLY = 2222;
    uint256 public constant MINT_PRICE = 0.0007 ether;
    string private baseURI;

    // Constructor: Pass the name, symbol to ERC721 and msg.sender to Ownable
    constructor() ERC721("Pesto Penguins", "PENG") Ownable() {}

    function mintNFT(uint256 amount) public payable {
        require(totalSupply() + amount <= MAX_SUPPLY, "Max supply exceeded");
        require(msg.value >= MINT_PRICE * amount, "Insufficient ETH");

        for (uint256 i = 0; i < amount; i++) {
            uint256 tokenId = totalSupply();
            _safeMint(msg.sender, tokenId);
        }
    }

    function setBaseURI(string memory uri) external onlyOwner {
        baseURI = uri;
    }

    function _baseURI() internal view override returns (string memory) {
        return baseURI;
    }

    function withdrawFunds() external onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }
}
