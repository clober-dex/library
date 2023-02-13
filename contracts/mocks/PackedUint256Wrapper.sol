// SPDX-License-Identifier: -
// License: https://license.clober.io/LICENSE.pdf

pragma solidity ^0.8.0;

import "../PackedUint256.sol";
import "../interfaces/CloberPackedUint256.sol";

contract PackedUint256Wrapper is CloberPackedUint256 {
    using PackedUint256 for uint256;

    function get8Unsafe(uint256 packed, uint256 index) external pure returns (uint8) {
        return packed.get8Unsafe(index);
    }

    function get8(uint256 packed, uint256 index) external pure returns (uint8) {
        return packed.get8(index);
    }

    function get16Unsafe(uint256 packed, uint256 index) external pure returns (uint16) {
        return packed.get16Unsafe(index);
    }

    function get16(uint256 packed, uint256 index) external pure returns (uint16) {
        return packed.get16(index);
    }

    function get32Unsafe(uint256 packed, uint256 index) external pure returns (uint32) {
        return packed.get32Unsafe(index);
    }

    function get32(uint256 packed, uint256 index) external pure returns (uint32) {
        return packed.get32(index);
    }

    function get64Unsafe(uint256 packed, uint256 index) external pure returns (uint64) {
        return packed.get64Unsafe(index);
    }

    function get64(uint256 packed, uint256 index) external pure returns (uint64) {
        return packed.get64(index);
    }

    // add
    function add8Unsafe(
        uint256 packed,
        uint256 index,
        uint8 value
    ) external pure returns (uint256) {
        return packed.add8Unsafe(index, value);
    }

    function add8(
        uint256 packed,
        uint256 index,
        uint8 value
    ) external pure returns (uint256) {
        return packed.add8(index, value);
    }

    function add16Unsafe(
        uint256 packed,
        uint256 index,
        uint16 value
    ) external pure returns (uint256) {
        return packed.add16Unsafe(index, value);
    }

    function add16(
        uint256 packed,
        uint256 index,
        uint16 value
    ) external pure returns (uint256) {
        return packed.add16(index, value);
    }

    function add32Unsafe(
        uint256 packed,
        uint256 index,
        uint32 value
    ) external pure returns (uint256) {
        return packed.add32Unsafe(index, value);
    }

    function add32(
        uint256 packed,
        uint256 index,
        uint32 value
    ) external pure returns (uint256) {
        return packed.add32(index, value);
    }

    function add64Unsafe(
        uint256 packed,
        uint256 index,
        uint64 value
    ) external pure returns (uint256) {
        return packed.add64Unsafe(index, value);
    }

    function add64(
        uint256 packed,
        uint256 index,
        uint64 value
    ) external pure returns (uint256) {
        return packed.add64(index, value);
    }

    // sub
    function sub8Unsafe(
        uint256 packed,
        uint256 index,
        uint8 value
    ) external pure returns (uint256) {
        return packed.sub8Unsafe(index, value);
    }

    function sub8(
        uint256 packed,
        uint256 index,
        uint8 value
    ) external pure returns (uint256) {
        return packed.sub8(index, value);
    }

    function sub16Unsafe(
        uint256 packed,
        uint256 index,
        uint16 value
    ) external pure returns (uint256) {
        return packed.sub16Unsafe(index, value);
    }

    function sub16(
        uint256 packed,
        uint256 index,
        uint16 value
    ) external pure returns (uint256) {
        return packed.sub16(index, value);
    }

    function sub32Unsafe(
        uint256 packed,
        uint256 index,
        uint32 value
    ) external pure returns (uint256) {
        return packed.sub32Unsafe(index, value);
    }

    function sub32(
        uint256 packed,
        uint256 index,
        uint32 value
    ) external pure returns (uint256) {
        return packed.sub32(index, value);
    }

    function sub64Unsafe(
        uint256 packed,
        uint256 index,
        uint64 value
    ) external pure returns (uint256) {
        return packed.sub64Unsafe(index, value);
    }

    function sub64(
        uint256 packed,
        uint256 index,
        uint64 value
    ) external pure returns (uint256) {
        return packed.sub64(index, value);
    }

    // update
    function update8Unsafe(
        uint256 packed,
        uint256 index,
        uint8 value
    ) external pure returns (uint256) {
        return packed.update8Unsafe(index, value);
    }

    function update8(
        uint256 packed,
        uint256 index,
        uint8 value
    ) external pure returns (uint256) {
        return packed.update8(index, value);
    }

    function update16Unsafe(
        uint256 packed,
        uint256 index,
        uint16 value
    ) external pure returns (uint256) {
        return packed.update16Unsafe(index, value);
    }

    function update16(
        uint256 packed,
        uint256 index,
        uint16 value
    ) external pure returns (uint256) {
        return packed.update16(index, value);
    }

    function update32Unsafe(
        uint256 packed,
        uint256 index,
        uint32 value
    ) external pure returns (uint256) {
        return packed.update32Unsafe(index, value);
    }

    function update32(
        uint256 packed,
        uint256 index,
        uint32 value
    ) external pure returns (uint256) {
        return packed.update32(index, value);
    }

    function update64Unsafe(
        uint256 packed,
        uint256 index,
        uint64 value
    ) external pure returns (uint256) {
        return packed.update64Unsafe(index, value);
    }

    function update64(
        uint256 packed,
        uint256 index,
        uint64 value
    ) external pure returns (uint256) {
        return packed.update64(index, value);
    }

    function total32(uint256 packed) external pure returns (uint256) {
        return packed.total32();
    }

    function total64(uint256 packed) external pure returns (uint256) {
        return packed.total64();
    }

    function sum32(
        uint256 packed,
        uint256 from,
        uint256 to
    ) external pure returns (uint256) {
        return packed.sum32(from, to);
    }

    function sum64(
        uint256 packed,
        uint256 from,
        uint256 to
    ) external pure returns (uint256) {
        return packed.sum64(from, to);
    }
}
