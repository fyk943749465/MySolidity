// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

import "@openzeppelin/contracts@4.4.1/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@4.4.1/access/Ownable.sol";

/*
 * 测试提交 git
 * 智能合约 Ownable 的理解: 
 * 只有部署该合约的地址,可以进行 mint操作. onlyOwner 修饰符决定了.
 */

contract ThinkingChain is ERC20, Ownable {

    constructor() ERC20("ThinkingChain", "TKCH") {
        _mint(msg.sender, 100000 * 10 ** decimals());
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}