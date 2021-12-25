// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity ^0.8.3;

contract FirstContract {
    address public owner;
    string public ownerName = "Chiquito de la calzada";
    uint256 public ownerAge = 23;
    string[] public posts;

    constructor(address _firstOwner){
        owner = _firstOwner;
    }

    function setOwnerState(address _newOwner, string memory _ownerName, uint256 _age)public{
        require(msg.sender == owner, "Error, you are not the owner");
        owner = _newOwner;
        ownerName = _ownerName;
        ownerAge = _age;
    }

    function _existsUrl(string memory _url)private view returns(bool){
        for(uint i=0; i<posts.length; i++){
            if(keccak256(abi.encodePacked(_url)) == keccak256(abi.encodePacked(posts[i]))){
                return true;
            }
        }
        return false;
    }

    function addPostUrl (string memory _url)public{
        require(msg.sender == owner, "Error, you are not the owner");
        require(!_existsUrl(_url), "The url already exists");
        posts.push(_url);
    }

    function getPosts() public view returns (string[] memory){
        return posts;
    }

    function deletePostUrl(string memory _url)public{
        require(_existsUrl(_url),"The provided url does not exist");
        for(uint i=0; i<posts.length; i++){
            if(keccak256(abi.encodePacked(_url))==keccak256(abi.encodePacked(posts[i]))){
                delete posts[i];
            }
        }
    }
}