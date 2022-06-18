// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;


// virtual

contract A {
    uint public x;

    uint public y;

    function setX(uint _x) virtual public {
        x = _x;
    }

    function setY(uint _y) virtual public {
        y = _y;
    }
}
// override

contract B is A {

    uint public z;

    function setZ(uint _z) public {
        z = _z;
    }

    function setX(uint _x) override public {
        x = _x + 2;
    }

}
