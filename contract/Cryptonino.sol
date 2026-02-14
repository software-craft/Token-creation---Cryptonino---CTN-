
// SPDX-License-Identifier: LPSD-3.0
pragma solidity 0.8.33;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Cryptonino is ERC20 {

    constructor(string memory name_, string memory symbol_) ERC20(name_, symbol_) { 
        _mint(msg.sender, 9000000 * 1e18);


    }

}
