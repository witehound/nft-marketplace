// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "nft-marketplace/node_modules/@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "nft-marketplace/node_modules/@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "nft-marketplace/contracts/Interfaces/INftContractFactory.sol";

contract NftContractFactory is INftContractFactory {
    address payable owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "only owner!");
        _;
    }

    constructor(address _ownwer) {
        owner = payable(_ownwer);
    }

    function createToken(string memory tokenUri, uint256 price)
        public
        onlyOwner
    {}
}
