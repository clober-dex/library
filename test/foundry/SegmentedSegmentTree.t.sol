// SPDX-License-Identifier: -
// License: https://license.clober.io/LICENSE.pdf

pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "forge-std/StdJson.sol";
import "../../contracts/mocks/SegmentedSegmentTreeWrapper.sol";

contract SegmentedSegmentTreeTest is Test {
    using stdJson for string;

    uint32 private constant _MAX_ORDER = 2**15;
    uint256 private constant _OVERFLOW_ERROR = 1;

    SegmentedSegmentTreeWrapper testWrapper;

    struct Array {
        uint64[_MAX_ORDER + 2] values;
    }

    function setUp() public {
        testWrapper = new SegmentedSegmentTreeWrapper();

        string memory root = vm.projectRoot();
        string memory path = string.concat(root, "/utils/segment-tree.dummy.json");
        string memory json = vm.readFile(path);
        Array memory array = abi.decode(json.parseRaw(".values"), (Array));
        for (uint256 i = 0; i < _MAX_ORDER; ++i) {
            testWrapper.update(i, array.values[i + 2]);
        }
    }

    function testOne(uint16 index) public {
        vm.assume(index <= _MAX_ORDER - 1);
        assertEq(testWrapper.get(index), testWrapper.query(index, index + 1));
    }

    function _sum(uint16 left, uint16 right) private view returns (uint64 ret) {
        ret = 0;
        for (uint256 i = left; i < right; ++i) {
            ret += testWrapper.get(i);
        }
    }

    function testSum(uint16 left, uint16 right) public {
        vm.assume(right <= _MAX_ORDER);
        vm.assume(left <= right);
        assertEq(testWrapper.query(left, right), _sum(left, right));
    }

    function testUpdate() public {
        for (uint64 i = 0; i < _MAX_ORDER; ++i) {
            uint64 value = testWrapper.get(i);
            uint64 replaced = testWrapper.update(i, i + 1);
            assertEq(value, replaced);
        }
        assertEq(testWrapper.query(0, 2), 3);
        testWrapper.update(0, 0);
        assertEq(testWrapper.query(0, 2), 2);
    }

    function testTotalOverflow() public {
        uint64 half64 = type(uint64).max / 2 + 1;
        testWrapper.update(0, half64);
        // map to the right node of layer 0, group 0
        vm.expectRevert(
            abi.encodeWithSelector(SegmentedSegmentTree.SegmentedSegmentTreeError.selector, _OVERFLOW_ERROR)
        );
        testWrapper.update(_MAX_ORDER / 2 - 1, half64);
    }
}
