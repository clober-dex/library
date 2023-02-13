// SPDX-License-Identifier: -
// License: https://license.clober.io/LICENSE.pdf

pragma solidity ^0.8.0;

import "../OctopusHeap.sol";
import "../interfaces/CloberOctopusHeap.sol";

contract OctopusHeapWrapper is CloberOctopusHeap {
    using OctopusHeap for OctopusHeap.Core;

    OctopusHeap.Core private _heap;

    function init() external {
        _heap.init();
    }

    function has(uint16 value) external view returns (bool) {
        return _heap.has(value);
    }

    function isEmpty() external view returns (bool) {
        return _heap.isEmpty();
    }

    function push(uint16 value) external {
        _heap.push(value);
    }

    function pop() external {
        _heap.pop();
    }

    function getRootWordAndHeap() external view returns (uint256 word, uint256[] memory heap) {
        return _heap.getRootWordAndHeap();
    }

    function popInMemory(uint256 word, uint256[] memory heap) external view returns (uint256, uint256[] memory) {
        return _heap.popInMemory(word, heap);
    }

    function root() external view returns (uint16) {
        return _heap.root();
    }
}
