//SPDX-License-Identifier: MIT

pragma solidity ^0.7.3;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract Decentratwitter is ERC721URIStorage{
    //some state variables
    uint256 public tokenCount;
    uint256 public postCount;
    struct Post {
        uint256 id;
        string hash;
        uint256 tipAmount;
        address payable author;
    }
    constructor() ERC721("Decentratwitter", "DAPP"){
        // the first parameter in the ERC721 function is the name of the contract and the second parameter is the symbol of the contract
        
    function mint(string memory _tokenURI) external returns (uint256) {
        tokenCount++;
        _safeMint(msg.sender, tokenCount);
        _setTokenURI(tokenCount, _tokenURI);
        setProfile(tokenCount);
        return (tokenCount);
    }
    }
}