// SPDX-License-Identifier: Apache-2.0
pragma solidity >=0.4.22 <0.9.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
contract MyToken is ERC20 {
  struct LastSpent {
    from;
    to;
    amount;
  }
  LastSpent private _last;
  constructor(string memory name, string memory symbol)
                                  ERC20(name, symbol) public {}
  function _beforeTokenTransfer(
                address from,
                address to,
                uint256 amount) internal virtual override {
    _last.from = from;
    _last.to = to;
    _last.amount = amount;
  }
}