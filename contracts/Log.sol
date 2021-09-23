// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
contract LogTable{

  // LogTableの作成
  struct Log {
    bool result;
    string chal;
    string k1;
    string k2;
    string myu;
    string gamma;
  }
  mapping(uint256 => Log) public Logs;

  // Log登録がTPAにしかできないように指定するための変数
  address tpa;

  // コントラクトデプロイ時に，TPAのアドレスを登録
  constructor(address _tpa){
    tpa = _tpa;
  }

  //Logの値からkeyとしてIDを生成，Logsに追加した後IDをreturn
  function registerLog( bool _result, string memory _chal, string memory _k1, string memory _k2, string memory _myu, string memory _gamma, uint256 _fitId) public returns(uint256){
    
    //トランザクション送信者がTPAでないと動かない
    require(
      tpa == msg.sender,
      "You are not TPA"
    );

    // logIdを入力データから生成
    uint256 logId = uint256(keccak256(abi.encodePacked(_result, _chal, _k1, _k2, _myu, _gamma, _fitId)));

    // LogTableに代入
    Logs[logId].result = _result;
    Logs[logId].chal = _chal;
    Logs[logId].k1 = _k1;
    Logs[logId].k2 = _k2;
    Logs[logId].myu = _myu;
    Logs[logId].gamma = _gamma;

    //TODO logIdをFIT[_fitId].logIdsにlogId追加するコントラクトをFIT側で定義→ここで実行

    return logId;
  }

  //ID配列を入力
  //該当するLogを配列にしてreturn
  function getLog(uint256[] memory _logId) public view returns(Log[] memory){
    Log[] memory LogMemory = new Log[](_logId.length);
    for(uint i = 0; i < _logId.length; i++) {
        LogMemory[i] = Logs[_logId[i]];
    }
    return LogMemory;
  }

  // 検証済みのLog情報の処理 => FIT.[_fitId].logから該当ログを削除
  function verifyLog(uint256[] memory _logId, uint256 _fitId) public {
  }
}