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

    address fitRegisterOwner;

    mapping(uint256 => FileIndex) public FIT;

    // コントラクトデプロイ時に，SPのアドレスを登録
    constructor(address _spa){
        fitRegisterOwner = _spa;
    }

    //固有データの登録
    function registerOriginalData(bytes memory _fileData) public returns(uint256){
        //トランザクション送信者がSPでないと動かない
        require(fitRegisterOwner == msg.sender, "You are not SP");
        uint256 fitId = uint256(keccak256(abi.encodePacked(msg.sender, _fileData)));
        require(
          FIT[fitId].users.length == 0,
          "This file is already registered"
        );
        FIT[fitId].hashedFile = _fileData;
        FIT[fitId].firstUser = msg.sender;
        return fitId;
    }
    
    //重複データの登録
    function registerDedUpData(uint256 _fitId) public {
        //トランザクション送信者がSPでないと動かない
        require(fitRegisterOwner == msg.sender, "You are not SP");
        //既に登録されているユーザがいなかったら固有データなのでだめ．
        require(
          FIT[_fitId].users.length != 0,
          "This is not an ded data"
        );
        address[] memory users = new address[](FIT[_fitId].users.length);
        users = FIT[_fitId].users;
        users[FIT[_fitId].users.length + 1] = msg.sender;
        FIT[_fitId].users = users;
    }

    //FileIndexTableから指定したIDのものを取得
    function getFIT(uint[] memory _fitIds) public view returns(FileIndex[] memory){
        FileIndex[] memory FITMemory = new FileIndex[](_fitIds.length);
        for(uint i = 0; i < _fitIds.length; i++) {
            FITMemory[i] = FIT[_fitIds[i]];
        }
        return FITMemory;
    }
}
