// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/**
 * @title MyTokenコントラクト
 * @notice 私のトークンコントラクト
 * @dev OpenZeppelinのERC20を継承
 */
contract MyToken is ERC20 {

    /**
     * @dev 何かしらの構造体
     * @param from from
     * @param to to
     * @param amount あまうんと
     */
    struct LastSpent {
        address from;
        address to;
        uint256 amount;
    }

    /** @dev 適当なstorage変数 */
    LastSpent private _last;

    constructor() ERC20("My Token", "MT") {
        _mint(msg.sender, 10000*10**18);
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual override {
        _last.from = from;
        _last.to = to;
        _last.amount = amount;
    }

    /**
     * @notice 適当なコントラクト情報を返す
     * @dev 特になし
     * @return cname コントラクト名
     * @return supply totalSupply()
     */
    function getContracInfo() public view returns (string memory cname, uint256 supply) {
        cname = "MyToken";
        supply = totalSupply();
    }
}