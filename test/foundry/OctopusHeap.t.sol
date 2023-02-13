// SPDX-License-Identifier: -
// License: https://license.clober.io/LICENSE.pdf

pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../../contracts/mocks/OctopusHeapWrapper.sol";

contract OctopusHeapTest is Test {
    uint16 private constant _MAX_HEAP_SIZE = type(uint16).max;

    uint16 private _min;

    OctopusHeapWrapper testWrapper;

    function setUp() public {
        testWrapper = new OctopusHeapWrapper();
        testWrapper.init();
        _min = type(uint16).max;
    }

    function _push(uint16[] calldata numbers) private {
        for (uint32 i = 0; i < numbers.length; ++i) {
            uint16 number = numbers[i];
            if (testWrapper.has(number)) continue;
            if (number < _min) _min = number;

            assertFalse(testWrapper.has(number));
            testWrapper.push(number);
            assertTrue(testWrapper.has(number));
            assertEq(testWrapper.root(), _min);
        }
    }

    function testPop(uint16[] calldata numbers) public {
        vm.assume(1 <= numbers.length && numbers.length <= _MAX_HEAP_SIZE);
        assertTrue(testWrapper.isEmpty());
        _push(numbers);
        assertFalse(testWrapper.isEmpty());
        (uint256 word, uint256[] memory heap) = testWrapper.getRootWordAndHeap();
        while (!testWrapper.isEmpty()) {
            (word, heap) = testWrapper.popInMemory(word, heap);

            _min = testWrapper.root();
            assertTrue(testWrapper.has(_min));
            testWrapper.pop();

            (uint256 expectedWord, uint256[] memory expectedHeap) = testWrapper.getRootWordAndHeap();
            assertEq(expectedWord, word);
            for (uint256 i = 0; i < 9; i++) {
                assertEq(expectedHeap[i], heap[i]);
            }

            assertFalse(testWrapper.has(_min));

            if (testWrapper.isEmpty()) break;
            assertGt(testWrapper.root(), _min);
        }
    }

    function testFullyFilledCase() public {
        // push
        for (uint16 number = 0; number <= 255 * 256; number++) {
            testWrapper.push(number);
            assertTrue(testWrapper.has(number));
        }
        // pop
        for (uint16 number = 0; number <= 255 * 256; number++) {
            assertEq(testWrapper.root(), number);
            testWrapper.pop();
        }
    }

    function testFullyFilledIndependentCase() public {
        // push
        for (uint16 number = 0; number <= 255; number++) {
            uint16 _number = number * 256;
            testWrapper.push(_number);
            assertTrue(testWrapper.has(_number));
        }
        // pop
        for (uint16 number = 0; number <= 255; number++) {
            uint16 _number = number * 256;
            assertEq(testWrapper.root(), _number);
            testWrapper.pop();
        }
    }
}
