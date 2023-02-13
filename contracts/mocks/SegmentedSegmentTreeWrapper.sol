// SPDX-License-Identifier: -
// License: https://license.clober.io/LICENSE.pdf

pragma solidity ^0.8.12;

import "@openzeppelin/contracts/utils/Strings.sol";

import "../interfaces/CloberSegmentedSegmentTree.sol";
import "../SegmentedSegmentTree.sol";

contract SegmentedSegmentTreeWrapper is CloberSegmentedSegmentTree {
    using SegmentedSegmentTree for SegmentedSegmentTree.Core;

    SegmentedSegmentTree.Core private _tree;

    function update(uint256 index, uint64 value) external returns (uint64) {
        return _tree.update(index, value);
    }

    struct UpdateParams {
        uint256 index;
        uint64 value;
    }

    function updateBatch(UpdateParams[] calldata values) external {
        for (uint256 i = 0; i < values.length; ++i) {
            _tree.update(values[i].index, values[i].value);
        }
    }

    function get(uint256 index) external view returns (uint64) {
        return _tree.get(index);
    }

    function total() external view returns (uint256) {
        return _tree.total();
    }

    function query(uint256 left, uint256 right) external view returns (uint256 ret) {
        ret = 0;
        try this.externalQuery(left, right) returns (uint256 _ret) {
            ret = _ret;
        } catch Error(string memory err) {
            revert(string.concat(err, " ", Strings.toString(left), ":", Strings.toString(right)));
        }
    }

    function externalQuery(uint256 left, uint256 right) external view returns (uint256) {
        return _tree.query(left, right);
    }
}
