// SPDX-License-Identifier: -
// License: https://license.clober.io/LICENSE.pdf

pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../../contracts/mocks/MinBitMapWrapper.sol";

contract MinBitMapTest is Test {
    uint16 private constant _MAX_HEAP_SIZE = type(uint16).max;

    uint24 private _min;

    MinBitMapWrapper testWrapper;

    function setUp() public {
        testWrapper = new MinBitMapWrapper();
        _min = type(uint24).max;
    }

    function _push(uint24[] calldata numbers) private {
        for (uint32 i = 0; i < numbers.length; ++i) {
            uint24 number = numbers[i];
            if (testWrapper.has(number)) continue;
            if (number < _min) _min = number;

            assertFalse(testWrapper.has(number), "BEFORE_PUSH");
            testWrapper.push(number);
            assertTrue(testWrapper.has(number), "AFTER_PUSH");
            assertEq(testWrapper.root(), _min, "ASSERT_MIN");
        }
    }

    function testPop(uint24[] calldata numbers) public {
        vm.assume(1 <= numbers.length && numbers.length <= _MAX_HEAP_SIZE);
        assertTrue(testWrapper.isEmpty(), "HAS_TO_BE_EMPTY");
        _push(numbers);
        assertFalse(testWrapper.isEmpty(), "HAS_TO_BE_OCCUPIED");
        while (!testWrapper.isEmpty()) {
            _min = testWrapper.root();
            assertTrue(testWrapper.has(_min), "BITMAP_HAS_ROOT");
            testWrapper.pop();
            assertFalse(testWrapper.has(_min), "ROOT_HAS_BEEN_POPPED");
            if (testWrapper.isEmpty()) break;
            assertGt(testWrapper.root(), _min, "ROOT_HAS_TO_BE_MIN");
        }
    }
}
