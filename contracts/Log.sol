// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
contract LogTable{

    struct Log {
        bool result;
        string chal;
        string k1;
        string k2;
        string myu;
        string gamma;
        bytes32 fitId;
    }
    mapping(uint256 => Log) public Logs;

    //Logの値からkeyとしてIDを生成，Logsに追加した後IDをreturn
    function registerLog( bool _result, string memory _chal, string memory _k1, string memory _k2, string memory _myu, string memory _gamma, bytes32 _fitId) public returns(uint256){
        uint256 id = uint256(keccak256(abi.encodePacked(_result, _chal, _k1, _k2, _myu, _gamma, _fitId)));
        Logs[id].result = _result;
        Logs[id].chal = _chal;
        Logs[id].k1 = _k1;
        Logs[id].k2 = _k2;
        Logs[id].myu = _myu;
        Logs[id].gamma = _gamma;
        Logs[id].fitId = _fitId;
        return id;
    }

    //ID配列を入力
    //該当するLogを配列にしてreturn
    function getLog(uint[] memory _logId) public view returns(Log[] memory){
        Log[] memory LogMemory = new Log[](_logId.length);
        for(uint i = 0; i < _logId.length; i++) {
            LogMemory[i] = Logs[_logId[i]];
        }
        return LogMemory;
    }
}