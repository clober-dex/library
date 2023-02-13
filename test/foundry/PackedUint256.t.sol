// SPDX-License-Identifier: -
// License: https://license.clober.io/LICENSE.pdf

pragma solidity ^0.8.0;

import "forge-std/Test.sol";

import "../../contracts/mocks/PackedUint256Wrapper.sol";

contract PackedUint256Test is Test {
    uint256 private constant _MAX_UINT8 = type(uint8).max;
    uint256 private constant _MAX_UINT16 = type(uint16).max;
    uint256 private constant _MAX_UINT32 = type(uint32).max;
    uint256 private constant _MAX_UINT64 = type(uint64).max;

    PackedUint256Wrapper testWrapper;

    function setUp() public {
        testWrapper = new PackedUint256Wrapper();
    }

    function testAdd8Unsafe(uint256 value, uint8 addValue) public {
        for (uint256 i = 0; i < 32; ++i) {
            uint8 beforeSlice = testWrapper.get8(value, i);
            uint8 boundedAddValue = uint8(bound(addValue, 0, _MAX_UINT8 - beforeSlice));

            uint256 ret = testWrapper.add8Unsafe(value, i, boundedAddValue);

            uint8 afterSlice = testWrapper.get8(ret, i);
            assertEq(beforeSlice + boundedAddValue, afterSlice);
        }
    }

    function testAdd16Unsafe(uint256 value, uint16 addValue) public {
        for (uint256 i = 0; i < 4; ++i) {
            uint16 beforeSlice = testWrapper.get16(value, i);
            uint16 boundedAddValue = uint16(bound(addValue, 0, _MAX_UINT16 - beforeSlice));

            uint256 ret = testWrapper.add16Unsafe(value, i, boundedAddValue);

            uint16 afterSlice = testWrapper.get16(ret, i);
            assertEq(beforeSlice + boundedAddValue, afterSlice);
        }
    }

    function testSub8Unsafe(uint256 value, uint8 subValue) public {
        for (uint256 i = 0; i < 32; ++i) {
            uint256 mask = _MAX_UINT8 << (i << 3);
            uint8 beforeSlice = testWrapper.get8(value, i);
            uint8 boundedSubValue = uint8(bound(subValue, 0, beforeSlice));

            uint256 ret = testWrapper.sub8Unsafe(value, i, boundedSubValue);

            uint8 afterSlice = testWrapper.get8(ret, i);

            assertEq(beforeSlice - boundedSubValue, afterSlice);
            assertEq(value - (value & mask), ret - (ret & mask));
        }
    }

    function testSub16Unsafe(uint256 value, uint16 subValue) public {
        for (uint256 i = 0; i < 8; ++i) {
            uint256 mask = _MAX_UINT16 << (i << 4);
            uint16 beforeSlice = testWrapper.get16(value, i);
            uint16 boundedSubValue = uint16(bound(subValue, 0, beforeSlice));

            uint256 ret = testWrapper.sub16Unsafe(value, i, boundedSubValue);

            uint16 afterSlice = testWrapper.get16(ret, i);
            assertEq(beforeSlice - boundedSubValue, afterSlice);
            assertEq(value - (value & mask), ret - (ret & mask));
        }
    }

    function testAdd32Unsafe(uint256 value, uint32 addValue) public {
        for (uint256 i = 0; i < 8; ++i) {
            uint32 beforeSlice = testWrapper.get32(value, i);
            uint32 boundedAddValue = uint32(bound(addValue, 0, _MAX_UINT32 - beforeSlice));

            uint256 ret = testWrapper.add32Unsafe(value, i, boundedAddValue);

            uint32 afterSlice = testWrapper.get32(ret, i);

            assertEq(beforeSlice + boundedAddValue, afterSlice);
        }
    }

    function testSub32Unsafe(uint256 value, uint32 subValue) public {
        for (uint256 i = 0; i < 8; ++i) {
            uint256 mask = _MAX_UINT32 << (i << 5);
            uint32 beforeSlice = testWrapper.get32(value, i);
            uint32 boundedSubValue = uint32(bound(subValue, 0, beforeSlice));

            uint256 ret = testWrapper.sub32Unsafe(value, i, boundedSubValue);

            uint32 afterSlice = testWrapper.get32(ret, i);

            assertEq(beforeSlice - boundedSubValue, afterSlice);
            assertEq(value - (value & mask), ret - (ret & mask));
        }
    }

    function testAdd64Unsafe(uint256 value, uint64 addValue) public {
        for (uint256 i = 0; i < 4; ++i) {
            uint64 beforeSlice = testWrapper.get64(value, i);
            uint64 boundedAddValue = uint64(bound(addValue, 0, _MAX_UINT64 - beforeSlice));

            uint256 ret = testWrapper.add64Unsafe(value, i, boundedAddValue);

            uint64 afterSlice = testWrapper.get64(ret, i);

            assertEq(beforeSlice + boundedAddValue, afterSlice);
        }
    }

    function testSub64Unsafe(uint256 value, uint64 subValue) public {
        for (uint256 i = 0; i < 4; ++i) {
            uint256 mask = _MAX_UINT64 << (i << 6);
            uint64 beforeSlice = testWrapper.get64(value, i);
            uint64 boundedSubValue = uint64(bound(subValue, 0, beforeSlice));

            uint256 ret = testWrapper.sub64Unsafe(value, i, boundedSubValue);

            uint64 afterSlice = testWrapper.get64(ret, i);

            assertEq(beforeSlice - boundedSubValue, afterSlice);
            assertEq(value - (value & mask), ret - (ret & mask));
        }
    }
}
