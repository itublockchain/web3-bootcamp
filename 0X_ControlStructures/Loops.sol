//SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;

contract Loops {
    uint256[15] public numbers0;
    uint256[15] public numbers1;
    bool public state = true;
    int256 public num = 0;

    function listByFor() public {
        uint256[15] memory nums = numbers0;

        for (uint256 i = 0; i < nums.length; i++) {
            //if(i == 13) continue;
            //if(i == 14) break;
            nums[i] = i;
        }

        numbers0 = nums;
    }

    function getArr0() public view returns (uint256[15] memory) {
        return numbers0;
    }

    function listByWhile() public {
        uint256 i = 0;
        while (i < numbers1.length) {
            numbers1[i] = i;
            i++;
        }
    }

    function getArr1() public view returns (uint256[15] memory) {
        return numbers1;
    }

    function crashByWhile() public {
        while (state) {
            num++;
            num--;
        }
    }
}
