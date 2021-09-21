// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract FileIndexTable {

  struct FileIndex {
    mapping(address => bool) owner; // ユーザが所持しているか　
    bytes[] hashedFile;
    bool isRegistered;
    mapping(uint => bool)[] logIds; // 検証前or検証済みのLogをstore　
  }

  mapping(uint256 => FileIndex) public FIT;

  address fitRegisterOwner;

  string a;

  // コントラクトデプロイ時に，SPのアドレスを登録
  constructor(address _spa) {
    fitRegisterOwner = _spa;
  }

  //固有データの登録　=>　fitのIDを返す
  function registerOriginalData(bytes[] memory _fileData, address _userAddress) public returns(uint256){
    //トランザクション送信者がSPでないと動かない
    require(fitRegisterOwner == msg.sender, "You are not SP");

    // ハッシュファイルからfitIDを生成
    uint256 fitId = uint256(keccak256(_fileData[0]));

    // 登録ユーザがすでに登録されているか
    require(
      FIT[fitId].owner[_userAddress],
      "This user has already registered as the owner"
    );
    // すでに登録済みのデータであれば不適切
    require(
      FIT[fitId].isRegistered,
      "This user has be already registered as the owner"
    );

    FIT[fitId].hashedFile = _fileData;
    FIT[fitId].owner[_userAddress] = true;

    // FIT[fitId].firstUser = msg.sender;
    // ↑固有ユーザの公開鍵を取得できるようにしたい→paraコントラクトからid検索で取得？

    return fitId;
  }
  
  //重複データの登録
  function registerDedUpData(uint256 _fitId, address _userAddress) public {
    //トランザクション送信者がSPでないと動かない
    require(fitRegisterOwner == msg.sender, "You are not SP");

    //既に登録されているユーザがいなかったら固有データなのでだめ．
    require(
      FIT[_fitId].isRegistered,
      "This data has not be registered"
    );
    FIT[_fitId].owner[_userAddress] = true;
  }

  //FileIndexTableから指定したIDのものを取得
  function getHashedFile(uint _fitId) public view returns(bytes[] memory){
    return FIT[_fitId].hashedFile;
  }
  
  // test用関数
  function test() public view returns(string memory) {
    return a;
  }
  function set(string memory _w) public returns(string memory) {
    a = _w;
    return a;
  }
}
