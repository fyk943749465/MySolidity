// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;


contract A {
    uint private num;
    function setNum(uint _num) public {
        num = _num;
    }

    function getNum(uint _num) public {
        num = _num + 1;
    }

    function getNum() public view returns (uint) {
        return num;
    }

    /*
     * 第一种:
     * 在 A 智能合约种调用 B 智能合约
     * 这里调用,需要传入B合约的地址,以及一个数字,如5
     * 这时候,调用B合约的getNum方法,就会读到结果是7
     */
    function bSetNum(address _bAddress, uint _num) public {
        B b = B(_bAddress);
        b.setNum(_num);
    }

    /*
     * 使用 call 函数调用合约B 中的函数
     * 这里的调用 合约B 中的 setNum函数之后,结果是存储在B合约中的
     */
    
    function bSetNumCall(address _bAddress, uint _num) public {
        (bool res, ) = _bAddress.call(abi.encodeWithSignature("setNum(uint256)", _num));
        if (!res) revert();
    }

    /*
     * 使用 delegatecall 调用合约 B 中的函数
     * 这里调用合约B中的setNum函数之后,结果是存储在了当前合约中,即A合约中,而不想要B合约中的状态变量的值
     * 这里也就说明了,call和delegatecall的区别
     */ 
    function bSetNumDelegatecall(address _bAddress, uint _num) public {
        (bool res,) = _bAddress.delegatecall(abi.encodeWithSignature("setNum(uint256)", _num));
        if (!res) revert();
    }
}

contract B {

    uint private num;
    function setNum(uint _num) public {
        num = _num +2;
    }

    function getNum() public view returns(uint) {
        return num;
    }

}