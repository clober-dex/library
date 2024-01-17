// SPDX-License-Identifier: -
// License: https://license.clober.io/LICENSE.pdf

pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../../contracts/mocks/DirtyUint64Wrapper.sol";
import "../../contracts/PackedUint256.sol";

contract DirtyUint64Test is Test {
    using PackedUint256 for uint256;

    error DirtyUint64Error(uint256 errorCode);

    uint256 private constant _OVERFLOW_ERROR = 0;
    uint256 private constant _UNDERFLOW_ERROR = 1;

    DirtyUint64Wrapper testWrapper;

    function setUp() public {
        testWrapper = new DirtyUint64Wrapper();
    }

    function testToDirtyAndToClean(uint64 cleanUint) public {
        if (cleanUint < type(uint64).max) {
            uint64 dirtyUint = testWrapper.toDirty(cleanUint);
            assertEq(dirtyUint, cleanUint + 1);
            assertEq(dirtyUint, cleanUint + 1);
            assertEq(testWrapper.toClean(dirtyUint), cleanUint);
        } else {
            assertEq(testWrapper.toDirtyUnsafe(cleanUint), 0);
            vm.expectRevert(abi.encodeWithSelector(DirtyUint64Error.selector, _OVERFLOW_ERROR));
            testWrapper.toDirty(cleanUint);
        }
    }

    function testAddClean(uint64 current, uint64 cleanUint) public {
        uint256 expected = uint256(current) + uint256(cleanUint);
        if (current == 0) {
            expected += 1;
        }
        if (expected <= type(uint64).max) {
            assertEq(testWrapper.addClean(current, cleanUint), expected);
        } else {
            vm.expectRevert(abi.encodeWithSelector(DirtyUint64Error.selector, _OVERFLOW_ERROR));
            testWrapper.addClean(current, cleanUint);
        }
    }

    function testAddDirty(uint64 current, uint64 dirtyUint) public {
        uint256 expected;
        if (current == 0 && dirtyUint == 0) {
            expected = 1;
        } else if (current == 0 || dirtyUint == 0) {
            expected = uint256(current) + uint256(dirtyUint);
        } else {
            expected = uint256(current) + uint256(dirtyUint) - 1;
        }
        if (expected <= type(uint64).max) {
            assertEq(testWrapper.addDirty(current, dirtyUint), expected);
        } else {
            vm.expectRevert(abi.encodeWithSelector(DirtyUint64Error.selector, _OVERFLOW_ERROR));
            testWrapper.addDirty(current, dirtyUint);
        }
    }

    function testSubClean(uint64 current, uint64 cleanUint) public {
        if (cleanUint < current) {
            assertEq(testWrapper.subClean(current, cleanUint), current - cleanUint);
        } else if (cleanUint == 0 && current == 0) {
            assertEq(testWrapper.subClean(current, cleanUint), 1);
        } else {
            vm.expectRevert(abi.encodeWithSelector(DirtyUint64Error.selector, _UNDERFLOW_ERROR));
            testWrapper.subClean(current, cleanUint);
        }
    }

    function testSubDirty(uint64 current, uint64 dirtyUint) public {
        if (current == 0 && dirtyUint <= 1) {
            assertEq(testWrapper.subDirty(current, dirtyUint), 1);
        } else if (current == 0 && dirtyUint > 1) {
            vm.expectRevert(abi.encodeWithSelector(DirtyUint64Error.selector, _UNDERFLOW_ERROR));
            testWrapper.subDirty(current, dirtyUint);
        } else if (dirtyUint == 0) {
            assertEq(testWrapper.subDirty(current, dirtyUint), current);
        } else if (current < dirtyUint) {
            vm.expectRevert(abi.encodeWithSelector(DirtyUint64Error.selector, _UNDERFLOW_ERROR));
            testWrapper.subDirty(current, dirtyUint);
        } else {
            assertEq(testWrapper.subDirty(current, dirtyUint), current - dirtyUint + 1);
        }
    }

    function testSumPackedDirtyUint256(uint256 packed) public {
        uint256 sum;
        for (uint256 i = 0; i < 4; i++) {
            for (uint256 j = i + 1; j <= 4; j++) {
                sum = 0;
                for (uint256 k = i; k < j; k++) {
                    sum += testWrapper.toClean(packed.get64(k));
                }
                if (sum <= type(uint64).max) {
                    assertEq(testWrapper.sumPackedUnsafe(packed, i, j), sum);
                }
            }
        }
    }
}
