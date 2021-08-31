// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;
/// @title Voting with delegation.
contract FileIndexTable {

    bytes32 file;

    struct FileIndex {
      address[] users;
      bytes hashedFile;
      address firstUser;
    }

    mapping(uint256 => FileIndex) public FIT;

    function registerOriginalData(bytes memory _fileData) public returns(uint256){
        uint256 fitId = uint256(keccak256(abi.encodePacked(msg.sender, _fileData)));
        require(
          FIT[fitId].users.length == 0,
          "This file is already registered"
        );
        FIT[fitId].hashedFile = _fileData;
        FIT[fitId].firstUser = msg.sender;
        return fitId;
    }

    function registerDedUpData(uint256 _fitId) public {
        require(
          FIT[_fitId].users.length != 0,
          "This is not an ded data"
        );
        address[] memory users = new address[](FIT[_fitId].users.length);
        users = FIT[_fitId].users;
        users[FIT[_fitId].users.length + 1] = msg.sender;
        FIT[_fitId].users = users;
    }

    function getFIT(uint[] memory _fitIds) public view returns(FileIndex[] memory){
        FileIndex[] memory FITMemory = new FileIndex[](_fitIds.length);
        for(uint i = 0; i < _fitIds.length; i++) {
            FITMemory[i] = FIT[_fitIds[i]];
        }
        return FITMemory;
    }
}
