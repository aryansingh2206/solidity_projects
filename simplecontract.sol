// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BasicContract {

    uint256 public data;
    function setData(uint256 _value) external {
        data = _value;
    }
    function getData() external view returns (uint256) {
        return data;
    }
    function doubleData() external {
        data = data * 2;
    }
    function resetData() external {
        data = 0;
    }
    function addNumbers(uint256 a, uint256 b) external pure returns (uint256) {
        return a + b;
    }
}
