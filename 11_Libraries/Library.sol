// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;

library Math {
    // Kullanılabilirlik
    // Ekonomik

    function plus( uint x, uint y) public pure returns(uint) {
        return x + y;
    }

    function minus(uint x, uint y) public pure returns(uint) {
        return x - y;
    }

    function multi(uint x, uint y) public pure returns(uint) {
        return x * y;
    }

    function divide(uint x, uint y) public pure returns(uint) {
        require(y != 0, "y sifir olmaz!");
        return x / y;
    }

    function min(uint a, uint b) internal pure returns (uint) {
        if (a <= b) {
            return a;
        } else {
            return b;
        }
    }

    function max(uint a, uint b) internal pure returns (uint) {
        if (a >= b) {
            return a;
        } else {
            return b;
        }
    }
}

library Search {
   function indexOf(uint[] memory list, uint data) public pure returns (uint) {
      for (uint i = 0; i < list.length; i++) {
          if (list[i] == data) {
               return i;
          }
      }
      return uint(list.length);
   }
}

contract Library {

    // using Math for uint;
    // using Search for uint[];

    function addeneme(uint[] memory x, uint y) public pure returns(uint) {
        return Search.indexOf(x,y);
    }
    
}   