// SPDX-License-Identifier: -
// License: https://license.clober.io/LICENSE.pdf

pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../../contracts/mocks/HeapWrapper.sol";

contract HeapTest is Test {
    uint16 private constant _MAX_HEAP_SIZE = type(uint16).max;

    uint24 private _min;

    HeapWrapper testWrapper;

    function setUp() public {
        testWrapper = new HeapWrapper();
        _min = type(uint24).max;
    }

    function _push(uint24[] memory numbers) private returns (uint256 length) {
        for (uint32 i = 0; i < numbers.length; ++i) {
            uint24 number = numbers[i];
            if (testWrapper.has(number)) continue;
            if (number < _min) _min = number;

            assertFalse(testWrapper.has(number), "BEFORE_PUSH");
            testWrapper.push(number);
            length += 1;
            assertTrue(testWrapper.has(number), "AFTER_PUSH");
            assertEq(testWrapper.root(), _min, "ASSERT_MIN");
        }
    }

    function testPopxx(uint24[] calldata numbers) public {
        vm.assume(1 <= numbers.length && numbers.length <= _MAX_HEAP_SIZE);
        assertTrue(testWrapper.isEmpty(), "HAS_TO_BE_EMPTY");
        uint256 length = _push(numbers);
        assertFalse(testWrapper.isEmpty(), "HAS_TO_BE_OCCUPIED");
        while (!testWrapper.isEmpty()) {
            _min = testWrapper.root();
            assertTrue(testWrapper.has(_min), "HEAP_HAS_ROOT");
            uint256 min;
            if (length == 1) {
                vm.expectRevert(abi.encodeWithSelector(Heap.HeapError.selector, Heap.EMPTY_ERROR));
                testWrapper.minGreaterThan(_min);
            } else {
                min = testWrapper.minGreaterThan(_min);
            }
            testWrapper.pop();
            length -= 1;
            if (length > 0) {
                assertTrue(testWrapper.root() == min, "WRONG_MIN");
            }

            assertFalse(testWrapper.has(_min), "ROOT_HAS_BEEN_POPPED");
            if (testWrapper.isEmpty()) break;
            assertGt(testWrapper.root(), _min, "ROOT_HAS_TO_BE_MIN");
        }
    }

    function testPushExistNumber(uint24 number) public {
        testWrapper.push(number);
        vm.expectRevert(abi.encodeWithSelector(Heap.HeapError.selector, Heap.ALREADY_EXISTS_ERROR));
        testWrapper.push(number);
    }

    function testPopWhenEmpty() public {
        vm.expectRevert(abi.encodeWithSelector(Heap.HeapError.selector, Heap.EMPTY_ERROR));
        testWrapper.pop();

        vm.expectRevert(abi.encodeWithSelector(Heap.HeapError.selector, Heap.EMPTY_ERROR));
        testWrapper.root();
    }
}
