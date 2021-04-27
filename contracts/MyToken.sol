// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import '@openzeppelin/contracts/token/ERC20/ERC20.sol';

contract MyToken is ERC20 {

    constructor () ERC20("The Rari Token", "ENZO") {
        _mint(msg.sender, 250000000 * 10 ** 18);
    }
}