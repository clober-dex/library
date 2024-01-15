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

    function _push(uint24[] memory numbers) private returns (uint24[] memory elements) {
        uint256 length;
        for (uint256 i = 0; i < numbers.length; ++i) {
            uint24 number = numbers[i];
            if (testWrapper.has(number)) continue;
            if (number < _min) _min = number;

            assertFalse(testWrapper.has(number), "BEFORE_PUSH");
            testWrapper.push(number);
            numbers[length] = number;
            length += 1;
            assertTrue(testWrapper.has(number), "AFTER_PUSH");
            assertEq(testWrapper.root(), _min, "ASSERT_MIN");
        }

        elements = new uint24[](length);
        for (uint256 i = 0; i < length; ++i) {
            elements[i] = numbers[i];
        }
    }

    function testPop(uint24[] calldata numbers) public {
        vm.assume(1 <= numbers.length && numbers.length <= _MAX_HEAP_SIZE);
        assertTrue(testWrapper.isEmpty(), "HAS_TO_BE_EMPTY");
        uint24[] memory elements = _push(numbers);
        uint256 length = elements.length;

        for (uint256 i = 0; i < length; i++) {
            for (uint256 j = i + 1; j < length; j++) {
                if (elements[i] > elements[j]) {
                    uint24 temp = elements[j];
                    elements[j] = elements[i];
                    elements[i] = temp;
                }
            }
        }

        for (uint256 i = 0; i < length - 1; i++) {
            if (elements[i] > 0) {
                assertTrue(testWrapper.minGreaterThan(elements[i] - 1) == elements[i], "WRONG_MIN");
            }
            assertTrue(testWrapper.minGreaterThan(elements[i]) == elements[i + 1], "WRONG_MIN");
        }
        vm.expectRevert(abi.encodeWithSelector(Heap.EmptyError.selector));
        testWrapper.minGreaterThan(elements[length - 1]);

        assertFalse(testWrapper.isEmpty(), "HAS_TO_BE_OCCUPIED");
        while (!testWrapper.isEmpty()) {
            _min = testWrapper.root();
            assertTrue(testWrapper.has(_min), "HEAP_HAS_ROOT");
            uint256 min;
            if (length == 1) {
                vm.expectRevert(abi.encodeWithSelector(Heap.EmptyError.selector));
                testWrapper.minGreaterThan(_min);
            } else {
                min = testWrapper.minGreaterThan(_min);
            }
            testWrapper.pop();
            length -= 1;
            if (length > 0) assertTrue(testWrapper.root() == min, "WRONG_MIN");

            assertFalse(testWrapper.has(_min), "ROOT_HAS_BEEN_POPPED");
            if (testWrapper.isEmpty()) break;
            assertGt(testWrapper.root(), _min, "ROOT_HAS_TO_BE_MIN");
        }
    }

    function testPushExistNumber(uint24 number) public {
        testWrapper.push(number);
        vm.expectRevert(abi.encodeWithSelector(Heap.AlreadyExistsError.selector));
        testWrapper.push(number);
    }

    function testPopWhenEmpty() public {
        vm.expectRevert(abi.encodeWithSelector(Heap.EmptyError.selector));
        testWrapper.pop();

        vm.expectRevert(abi.encodeWithSelector(Heap.EmptyError.selector));
        testWrapper.root();
    }
}
