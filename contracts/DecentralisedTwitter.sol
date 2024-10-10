//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract Decentratwitter is ERC721URIStorage {
    uint256 public tokenCount;
    uint256 public postCount;
    mapping(uint256 => Post) public posts;
    // address --> nft id
    mapping(address => uint256) public profiles;

    struct Post {
        uint256 id;
        string hash;
        uint256 tipAmount;
        address payable author;
    }

    event PostCreated(
        uint256 id,
        string hash,
        uint256 tipAmount,
        address payable author
    );

    event PostTipped(
        uint256 id,
        string hash,
        uint256 tipAmount,
        address payable author
    );

    constructor() ERC721("Decentratwitter", "DAPP") {}

    function mint(string memory _tokenURI) external returns (uint256) {
        tokenCount++;
        _safeMint(msg.sender, tokenCount);
        _setTokenURI(tokenCount, _tokenURI);
        setProfile(tokenCount);
        return (tokenCount);
    }

    function setProfile(uint256 _id) public {
        require(
            ownerOf(_id) == msg.sender,
            "Must own the nft you want to select as your profile"
        );
        profiles[msg.sender] = _id;
    }

    function uploadPost(string memory _postHash) external {
        // Check that the user owns an nft
        require(
            balanceOf(msg.sender) > 0,
            "Must own a decentratwitter nft to post"
        );
        // Make sure the post hash exists
        require(bytes(_postHash).length > 0, "Cannot pass an empty hash");
        // Increment post count
        postCount++;
        // Add post to the contract
        posts[postCount] = Post(postCount, _postHash, 0, payable(msg.sender));
        // Trigger an event
        emit PostCreated(postCount, _postHash, 0, payable(msg.sender));
    }
}