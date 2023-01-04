// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "nft-marketplace/node_modules/@openzeppelin/contracts/utils/Counters.sol";
import "nft-marketplace/node_modules/@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "nft-marketplace/node_modules/@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "nft-marketplace/node_modules/hardhat/console.sol";
import "nft-marketplace/contracts/NftContractFactory.sol";
import "nft-marketplace/contracts/Interfaces/INftContractFactory.sol";

contract NftMarketPlace {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIds;
    Counters.Counter private _itemsSold;

    address payable owner;
    address public _factory;
    uint256 private _listingPrice = 0.0015 ether;

    mapping(uint256 => MarketItem) private idMarketItems;

    struct MarketItem {
        uint256 tokenId;
        address payable seller;
        address payable owner;
        uint256 price;
        bool sold;
    }

    event MarketItemCreated(
        uint256 indexed tokenId,
        address payable seller,
        address payable owner,
        uint256 price,
        bool sold
    );

    modifier onlyOwner() {
        require(msg.sender == owner, "only owner!");
        _;
    }

    constructor() {
        owner = payable(msg.sender);
    }

    function createNftFactory() public onlyOwner {
        _factory = new NftContractFactory(address(this));
    }

    function updateListingPrice(uint256 newListingPrice) public onlyOwner {
        _listingPrice = newListingPrice;
    }

    function getListingPrice() public view returns (uint256) {
        return _listingPrice;
    }
}
