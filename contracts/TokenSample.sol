// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TokenSample is ERC20 {
    constructor() ERC20("My Token", "MT") {
        _mint(msg.sender, 10000*10**18);
    }
}