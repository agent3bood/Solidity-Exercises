// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract SumArray {
    function sumArray(uint256[] calldata arr) public pure returns (uint256) {
        uint ans = 0;
        for (uint i = 0; i < arr.length; i++) {
            ans += arr[i];
        }
        return ans;
    }
}
