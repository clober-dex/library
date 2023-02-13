// SPDX-License-Identifier: -
// License: https://license.clober.io/LICENSE.pdf

pragma solidity ^0.8.0;

import "../DirtyUint64.sol";

/**
 * @title Dirty Uint64
 * @notice Adds, subtracts, and converts clean (original) and dirty (a non-zero representation of the original)
 * `uint64` values.
 */
interface CloberDirtyUint64 {
    /**
     * @notice Converts a clean uint64 value to its dirty representation.
     * @param cleanUint The clean uint64 value to convert.
     * @return The dirty representation of the clean uint64 value.
     */
    function toDirtyUnsafe(uint64 cleanUint) external pure returns (uint64);

    /**
     * @notice Converts a clean uint64 value to its dirty representation.
     * @param cleanUint The clean uint64 value to convert.
     * @return The dirty representation of the clean uint64 value.
     */
    function toDirty(uint64 cleanUint) external pure returns (uint64);

    /**
     * @notice Converts a dirty uint64 value to its clean representation.
     * @param dirtyUint The dirty uint64 value to convert.
     * @return The clean representation of the dirty uint64 value.
     */
    function toClean(uint64 dirtyUint) external pure returns (uint64);

    /**
     * @notice Adds a clean uint64 value to a current uint64 value and returns the result.
     * @param current The current uint64 value.
     * @param cleanUint The clean uint64 value to add.
     * @return The result of adding the clean uint64 value to the current uint64 value.
     */
    function addClean(uint64 current, uint64 cleanUint) external pure returns (uint64);

    /**
     * @notice Adds a dirty uint64 value to a current uint64 value and returns the result.
     * @param current The current uint64 value.
     * @param dirtyUint The dirty uint64 value to add.
     * @return The result of adding the dirty uint64 value to the current uint64 value.
     */
    function addDirty(uint64 current, uint64 dirtyUint) external pure returns (uint64);

    /**
     * @notice Subtracts a clean uint64 value from a current uint64 value and returns the result.
     * @param current The current uint64 value.
     * @param cleanUint The clean uint64 value to subtract.
     * @return The result of subtracting the clean uint64 value from the current uint64 value.
     */
    function subClean(uint64 current, uint64 cleanUint) external pure returns (uint64);

    /**
     * @notice Subtracts a dirty uint64 value from a current uint64 value and returns the result.
     * @param current The current uint64 value.
     * @param dirtyUint The dirty uint64 value to subtract.
     * @return The result of subtracting the dirty uint64 value from the current uint64 value.
     */
    function subDirty(uint64 current, uint64 dirtyUint) external pure returns (uint64);
}
