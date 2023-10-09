// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

import "@openzeppelin/contracts@4.4.1/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@4.4.1/access/AccessControl.sol";

/*
 * 权限控制
 * 定义了 mint 函数只能是 MINTER_ROLE角色的用户才能进行调用
 * MINTER_ROLE 角色是自定义角色
 */ 
contract Roles is ERC20, AccessControl {
    // 定义了一个挖矿的角色
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    // 角色的ADMIN角色
    bytes32 public constant MINTER_ADMIN_ROLE = keccak256("MINTER_ADMIN_ROLE");

    constructor() ERC20("Roles", "ROLE") {
        _mint(msg.sender, 1000000000 * 10 ** decimals());
        // 默认的 admin 的角色 合约创建者
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        // 定义的挖矿的角色 也给到合约的创建者
        _grantRole(MINTER_ROLE, msg.sender);
    }

    // 只有 MINTER_ROLE 角色的用户,才能进行挖矿
    function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) {
        _mint(to, amount);
    }

    /*
     * 我们可以拿到 MINTER_ROLE 的具体值 bytes32: 0x9f2df0fed2c77648de5860a4cc508cd0818c85b8b8a1ab4ceeef8d981c8956a6
     * 我们也可以拿到 MINTER_ADMIN_ROLE 的具体值  bytes32: 0x70480ee89cb38eff00b7d23da25713d52ce19c6ed428691d22c58b2f615e3d67
     * 而 setRoleAdmin 方法, 是可以 设置 role 角色的 admin账账户的.
     * 而我想不通这样做有什么意义,但是可以这样做
     */
    function setRoleAdmin(bytes32 role, bytes32 adminRole) public {
        super._setRoleAdmin(role, adminRole);
    }
}