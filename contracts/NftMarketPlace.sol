// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "nft-marketplace/node_modules/@openzeppelin/contracts/utils/Counters.sol";
import "nft-marketplace/node_modules/@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "nft-marketplace/node_modules/@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "nft-marketplace/node_modules/hardhat/console.sol";

contract NftMarketPlace {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIds;
    Counters.Counter private _itemsSold;

    address payable owner;
    address public _factory;
    uint256 private _listingPrice = 0.0015 ether;

    bool private _isFactory = false;

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

    function updateListingPrice(uint256 newListingPrice) public onlyOwner {
        _listingPrice = newListingPrice;
    }

    function getListingPrice() public view returns (uint256) {
        return _listingPrice;
    }

    function createNftToken(string memory tokenUri, uint256 price)
        public
        payable
        returns (uint256)
    {
        _tokenIds.increment();
        uint256 newTokenId = _tokenIds.current();

        _mint(msg.sender, newTokenId);

        _setTokenUri(newTokenId, tokenUri);

        createMarketItem(newTokenId, price);

        return newTokenId;
    }

    function createMarketItem(uint256 newTokenId, uint256 price) internal {
        require(price > 0, "err : price must be at least 1");
        require(
            msg.value >= _listingPrice,
            "err : price must be greater than listing price"
        );

        idMarketItems[newTokenId] = MarketItem(
            newTokenId,
            payable(msg.sender),
            payable(address(this)),
            price,
            false
        );

        _transfer(msg.sender, address(this), newTokenId);

        emit MarketItemCreated(
            newTokenId,
            msg.sender,
            address(this),
            price,
            false
        );
    }

    //next
}
