// SPDX-License-Identifier: -
// License: https://license.clober.io/LICENSE.pdf

pragma solidity ^0.8.0;

import "../Heap.sol";
import "../interfaces/CloberHeap.sol";

contract HeapWrapper is CloberHeap {
    using Heap for mapping(uint256 => uint256);

    mapping(uint256 => uint256) private _heap;

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

    function minGreaterThan(uint24 value) external view returns (uint24) {
        return _heap.minGreaterThan(value);
    }
}
