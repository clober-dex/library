// SPDX-License-Identifier: -
// License: https://license.clober.io/LICENSE.pdf

pragma solidity ^0.8.0;

/**
 * @title Packed Uint256
 * @notice This library treats uint256 as a group of uint8, uint16, uint32, or uint64 and adds,
 * subtracts, or updates the elements of the group by indexing them.
 * `*Unsafe` optimizes gas costs by using assembly under the assumption
 * that the user will not provide an input that would cause an arithmetic underflow or overflow.
 */
interface CloberPackedUint256 {
    /**
     * @notice Retrieves a uint8 from the packed uint256 at the specified index with unchecked.
     * @param packed The packed uint256 to retrieve the uint8 from.
     * @param index The index of the uint8 to retrieve.
     * @return The uint8 at the specified index of the packed uint256.
     */
    function get8Unsafe(uint256 packed, uint256 index) external pure returns (uint8);

    /**
     * @notice Retrieves a uint8 from the packed uint256 at the specified index.
     * @param packed The packed uint256 to retrieve the uint8 from.
     * @param index The index of the uint8 to retrieve.
     * @return The uint8 at the specified index of the packed uint256.
     */
    function get8(uint256 packed, uint256 index) external pure returns (uint8);

    /**
     * @notice Retrieves a uint16 from the packed uint256 at the specified index with unchecked.
     * @param packed The packed uint256 to retrieve the uint16 from.
     * @param index The index of the uint16 to retrieve.
     * @return The uint16 at the specified index of the packed uint256.
     */
    function get16Unsafe(uint256 packed, uint256 index) external pure returns (uint16);

    /**
     * @notice Retrieves a uint16 from the packed uint256 at the specified index.
     * @param packed The packed uint256 to retrieve the uint16 from.
     * @param index The index of the uint16 to retrieve.
     * @return The uint16 at the specified index of the packed uint256.
     */
    function get16(uint256 packed, uint256 index) external pure returns (uint16);

    /**
     * @notice Retrieves a uint32 from the packed uint256 at the specified index with unchecked.
     * @param packed The packed uint256 to retrieve the uint32 from.
     * @param index The index of the uint32 to retrieve.
     * @return The uint32 at the specified index of the packed uint256.
     */
    function get32Unsafe(uint256 packed, uint256 index) external pure returns (uint32);

    /**
     * @notice Retrieves a uint32 from the packed uint256 at the specified index.
     * @param packed The packed uint256 to retrieve the uint32 from.
     * @param index The index of the uint32 to retrieve.
     * @return The uint32 at the specified index of the packed uint256.
     */
    function get32(uint256 packed, uint256 index) external pure returns (uint32);

    /**
     * @notice Retrieves a uint64 from the packed uint256 at the specified index with unchecked.
     * @param packed The packed uint256 to retrieve the uint64 from.
     * @param index The index of the uint64 to retrieve.
     * @return The uint64 at the specified index of the packed uint256.
     */
    function get64Unsafe(uint256 packed, uint256 index) external pure returns (uint64);

    /**
     * @notice Retrieves a uint64 from the packed uint256 at the specified index.
     * @param packed The packed uint256 to retrieve the uint64 from.
     * @param index The index of the uint64 to retrieve.
     * @return The uint64 at the specified index of the packed uint256.
     */
    function get64(uint256 packed, uint256 index) external pure returns (uint64);

    /**
     * @notice Adds a uint8 value to a uint8 element in the packed uint256 with unchecked.
     * @param packed The packed uint256.
     * @param index The index at which to add the uint8.
     * @param value The uint8 value to add.
     * @return The resulting packed uint256 with the uint8 added at the specified index.
     */
    function add8Unsafe(uint256 packed, uint256 index, uint8 value) external pure returns (uint256);

    /**
     * @notice Adds a uint8 value to a uint8 element in the packed uint256.
     * @param packed The packed uint256.
     * @param index The index at which to add the uint8.
     * @param value The uint8 value to add.
     * @return The resulting packed uint256 with the uint8 added at the specified index.
     */
    function add8(uint256 packed, uint256 index, uint8 value) external pure returns (uint256);

    /**
     * @notice Adds a uint16 value to a uint16 element in the packed uint256 with unchecked.
     * @param packed The packed uint256.
     * @param index The index at which to add the uint16.
     * @param value The uint16 value to add.
     * @return The resulting packed uint256 with the uint16 added at the specified index.
     */
    function add16Unsafe(uint256 packed, uint256 index, uint16 value) external pure returns (uint256);

    /**
     * @notice Adds a uint16 value to a uint16 element in the packed uint256.
     * @param packed The packed uint256.
     * @param index The index at which to add the uint16.
     * @param value The uint16 value to add.
     * @return The resulting packed uint256 with the uint16 added at the specified index.
     */
    function add16(uint256 packed, uint256 index, uint16 value) external pure returns (uint256);

    /**
     * @notice Adds a uint32 value to a uint32 element in the packed uint256 with unchecked.
     * @param packed The packed uint256.
     * @param index The index at which to add the uint32.
     * @param value The uint32 value to add.
     * @return The resulting packed uint256 with the uint32 added at the specified index.
     */
    function add32Unsafe(uint256 packed, uint256 index, uint32 value) external pure returns (uint256);

    /**
     * @notice Adds a uint32 value to a uint32 element in the packed uint256.
     * @param packed The packed uint256.
     * @param index The index at which to add the uint32.
     * @param value The uint32 value to add.
     * @return The resulting packed uint256 with the uint32 added at the specified index.
     */
    function add32(uint256 packed, uint256 index, uint32 value) external pure returns (uint256);

    /**
     * @notice Adds a uint64 value to a uint64 element in the packed uint256 with unchecked.
     * @param packed The packed uint256.
     * @param index The index at which to add the uint64.
     * @param value The uint64 value to add.
     * @return The resulting packed uint256 with the uint64 added at the specified index.
     */
    function add64Unsafe(uint256 packed, uint256 index, uint64 value) external pure returns (uint256);

    /**
     * @notice Adds a uint64 value to a uint64 element in the packed uint256.
     * @param packed The packed uint256.
     * @param index The index at which to add the uint64.
     * @param value The uint64 value to add.
     * @return The resulting packed uint256 with the uint64 added at the specified index.
     */
    function add64(uint256 packed, uint256 index, uint64 value) external pure returns (uint256);

    /**
     * @notice Subtracts a uint8 value to a uint8 element in the packed uint256 with unchecked.
     * @param packed The packed uint256.
     * @param index The index at which to subtract the uint8.
     * @param value The uint8 value to subtract.
     * @return The resulting packed uint256 with the uint8 subtracted at the specified index.
     */
    function sub8Unsafe(uint256 packed, uint256 index, uint8 value) external pure returns (uint256);

    /**
     * @notice Subtracts a uint8 value to a uint8 element in the packed uint256.
     * @param packed The packed uint256.
     * @param index The index at which to subtract the uint8.
     * @param value The uint8 value to subtract.
     * @return The resulting packed uint256 with the uint8 subtracted at the specified index.
     */
    function sub8(uint256 packed, uint256 index, uint8 value) external pure returns (uint256);

    /**
     * @notice Subtracts a uint16 value from the packed uint256 at the specified index with unchecked.
     * @param packed The packed uint256.
     * @param index The index at which to subtract the uint16.
     * @param value The uint16 value to subtract.
     * @return The resulting packed uint256 with the uint16 subtracted at the specified index.
     */
    function sub16Unsafe(uint256 packed, uint256 index, uint16 value) external pure returns (uint256);

    /**
     * @notice Subtracts a uint16 value to a uint16 element in the packed uint256.
     * @param packed The packed uint256.
     * @param index The index at which to subtract the uint16.
     * @param value The uint16 value to subtract.
     * @return The resulting packed uint256 with the uint16 subtracted at the specified index.
     */
    function sub16(uint256 packed, uint256 index, uint16 value) external pure returns (uint256);

    /**
     * @notice Subtracts a uint32 value to a uint32 element in the packed uint256 with unchecked.
     * @param packed The packed uint256.
     * @param index The index at which to subtract the uint32.
     * @param value The uint32 value to subtract.
     * @return The resulting packed uint256 with the uint32 subtracted at the specified index.
     */
    function sub32Unsafe(uint256 packed, uint256 index, uint32 value) external pure returns (uint256);

    /**
     * @notice Subtracts a uint32 value to a uint32 element in the packed uint256.
     * @param packed The packed uint256.
     * @param index The index at which to subtract the uint32.
     * @param value The uint32 value to subtract.
     * @return The resulting packed uint256 with the uint32 subtracted at the specified index.
     */
    function sub32(uint256 packed, uint256 index, uint32 value) external pure returns (uint256);

    /**
     * @notice Subtracts a uint64 value to a uint64 element in the packed uint256 with unchecked.
     * @param packed The packed uint256.
     * @param index The index at which to subtract the uint64.
     * @param value The uint64 value to subtract.
     * @return The resulting packed uint256 with the uint64 subtracted at the specified index.
     */
    function sub64Unsafe(uint256 packed, uint256 index, uint64 value) external pure returns (uint256);

    /**
     * @notice Subtracts a uint64 value to a uint64 element in the packed uint256.
     * @param packed The packed uint256.
     * @param index The index at which to subtract the uint64.
     * @param value The uint64 value to subtract.
     * @return The resulting packed uint256 with the uint64 subtracted at the specified index.
     */
    function sub64(uint256 packed, uint256 index, uint64 value) external pure returns (uint256);

    /**
     * @notice Updates the packed uint256 at the specified index with a uint8 value with unchecked.
     * @param packed The packed uint256.
     * @param index The index of the packed uint256 to update.
     * @param value The uint8 value to update the packed uint256 with.
     * @return The resulting packed uint256 with the uint8 value at the specified index.
     */
    function update8Unsafe(uint256 packed, uint256 index, uint8 value) external pure returns (uint256);

    /**
     * @notice Updates the packed uint256 at the specified index with a uint8 value.
     * @param packed The packed uint256.
     * @param index The index of the packed uint256 to update.
     * @param value The uint8 value to update the packed uint256 with.
     * @return The resulting packed uint256 with the uint8 value at the specified index.
     */
    function update8(uint256 packed, uint256 index, uint8 value) external pure returns (uint256);

    /**
     * @notice Updates the packed uint256 at the specified index with a uint16 value with unchecked.
     * @param packed The packed uint256.
     * @param index The index of the packed uint256 to update.
     * @param value The uint16 value to update the packed uint256 with.
     * @return The resulting packed uint256 with the uint16 value at the specified index.
     */
    function update16Unsafe(uint256 packed, uint256 index, uint16 value) external pure returns (uint256);

    /**
     * @notice Updates the packed uint256 at the specified index with a uint16 value.
     * @param packed The packed uint256.
     * @param index The index of the packed uint256 to update.
     * @param value The uint16 value to update the packed uint256 with.
     * @return The resulting packed uint256 with the uint16 value at the specified index.
     */
    function update16(uint256 packed, uint256 index, uint16 value) external pure returns (uint256);

    /**
     * @notice Updates the packed uint256 at the specified index with a uint32 value with unchecked.
     * @param packed The packed uint256.
     * @param index The index of the packed uint256 to update.
     * @param value The uint32 value to update the packed uint256 with.
     * @return The resulting packed uint256 with the uint32 value at the specified index.
     */
    function update32Unsafe(uint256 packed, uint256 index, uint32 value) external pure returns (uint256);

    /**
     * @notice Updates the packed uint256 at the specified index with a uint32 value.
     * @param packed The packed uint256.
     * @param index The index of the packed uint256 to update.
     * @param value The uint32 value to update the packed uint256 with.
     * @return The resulting packed uint256 with the uint32 value at the specified index.
     */
    function update32(uint256 packed, uint256 index, uint32 value) external pure returns (uint256);

    /**
     * @notice Updates the packed uint256 at the specified index with a uint64 value with unchecked.
     * @param packed The packed uint256.
     * @param index The index of the packed uint256 to update.
     * @param value The uint64 value to update the packed uint256 with.
     * @return The resulting packed uint256 with the uint64 value at the specified index.
     */
    function update64Unsafe(uint256 packed, uint256 index, uint64 value) external pure returns (uint256);

    /**
     * @notice Updates the packed uint256 at the specified index with a uint64 value.
     * @param packed The packed uint256.
     * @param index The index of the packed uint256 to update.
     * @param value The uint64 value to update the packed uint256 with.
     * @return The resulting packed uint256 with the uint64 value at the specified index.
     */
    function update64(uint256 packed, uint256 index, uint64 value) external pure returns (uint256);

    /**
     * @notice Calculates the sum of all the uint32 values in the packed uint256.
     * @param packed The packed uint256.
     * @return The sum of all the uint32 values in the packed uint256.
     */
    function total32(uint256 packed) external pure returns (uint256);

    /**
     * @notice Calculates the sum of all the uint64 values in the packed uint256.
     * @param packed The packed uint256.
     * @return The sum of all the uint64 values in the packed uint256.
     */
    function total64(uint256 packed) external pure returns (uint256);

    /**
     * @notice Calculates the sum of the uint32 values in the packed uint256 within the specified range.
     * @param packed The packed uint256.
     * @param from The starting index (inclusive) of the uint32 values to add up.
     * @param to The ending index (exclusive) of the uint32 values to add up.
     * @return The sum of the uint32 values in the packed uint256 within the specified range.
     */
    function sum32(uint256 packed, uint256 from, uint256 to) external pure returns (uint256);

    /**
     * @notice Calculates the sum of the uint64 values in the packed uint256 within the specified range.
     * @param packed The packed uint256.
     * @param from The starting index (inclusive) of the uint64 values to add up.
     * @param to The ending index (exclusive) of the uint64 values to add up.
     * @return The sum of the uint64 values in the packed uint256 within the specified range.
     */
    function sum64(uint256 packed, uint256 from, uint256 to) external pure returns (uint256);
}
