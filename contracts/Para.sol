// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
contract Para{

    // 公開鍵構造体
    struct PubKey {
        string pubkey;
    }
    
    //　Para各値の定義
    mapping(address => PubKey) public PubKeys;
    string public pairing;
    string public u;
    string public g;

    function RegisterParams(string memory _pairing,string memory _g,string memory _u) public {
        pairing = _pairing;
        g = _g;
        u = _u;
        // etc...
    }
    function RegisterPubKey(string memory _pubkey) public {
        address user = msg.sender;
        PubKeys[user].pubkey = _pubkey;
    }
}