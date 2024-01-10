// SPDX-License-Identifier: -
// License: https://license.clober.io/LICENSE.pdf

pragma solidity ^0.8.0;

import "../MinBitMap.sol";
import "../interfaces/CloberMinBitMap.sol";

contract MinBitMapWrapper is CloberMinBitMap {
    using MinBitMap for MinBitMap.Core;

    MinBitMap.Core private _heap;

    function has(uint24 value) external view returns (bool) {
        return _heap.has(value);
    }

    function isEmpty() external view returns (bool) {
        return _heap.isEmpty();
    }

    function push(uint24 value) external {
        _heap.push(value);
    }

    function pop() external {
        _heap.pop();
    }

    function root() external view returns (uint24) {
        return _heap.root();
    }

    function getNextMinValue(uint24 value) external view returns (uint24) {
        return _heap.getNextMinValue(value);
    }
}
