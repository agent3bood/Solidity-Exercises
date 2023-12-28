// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract FilterOddNumbers {
    /*
        This exercise assumes you understand how to manipulate Array.
        1. Function `filterOdd` takes an array of uint256 as argument. 
        2. Filter and return an array with the odd numbers removed.
        Note: this is tricky because you cannot allocate a dynamic array in memory, 
              you need to count the even numbers then declare an array of that size.
    */

    function filterOdd(uint256[] memory _arr)
    public
    view
    returns (uint256[] memory)
    {
        uint odds = 0;
        for (uint i = 0; i < _arr.length; i++) {
            if (_arr[i] % 2 == 0) {
                odds += 1;
            }
        }
        uint[] memory ans = new uint[](odds);
        uint pointer = 0;
        for (uint i = 0; i < _arr.length; i++) {
            if (_arr[i] % 2 == 0) {
                ans[pointer] = _arr[i];
                pointer += 1;
            }
        }
        return ans;
    }
}
