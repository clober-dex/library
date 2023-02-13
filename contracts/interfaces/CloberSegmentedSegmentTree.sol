// SPDX-License-Identifier: -
// License: https://license.clober.io/LICENSE.pdf

pragma solidity ^0.8.0;

/**
🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲

                  Segmented Segment Tree
                               by Clober

____________/\\\_______________/\\\\\____________/\\\____
 __________/\\\\\___________/\\\\////___________/\\\\\____
  ________/\\\/\\\________/\\\///______________/\\\/\\\____
   ______/\\\/\/\\\______/\\\\\\\\\\\_________/\\\/\/\\\____
    ____/\\\/__\/\\\_____/\\\\///////\\\_____/\\\/__\/\\\____
     __/\\\\\\\\\\\\\\\\_\/\\\______\//\\\__/\\\\\\\\\\\\\\\\_
      _\///////////\\\//__\//\\\______/\\\__\///////////\\\//__
       ___________\/\\\_____\///\\\\\\\\\/_____________\/\\\____
        ___________\///________\/////////_______________\///_____

          4 Layers of 64-bit nodes, hence 464

🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲
*/

/**
 * @title Segmented Segment Tree
 * @notice uint64 values are stored here to efficiently query the sum of a given range.
 * A total of 32768 values can be stored in the segment tree.
 * A query will require at most 14 storage reads, and an update to the tree will require 4 storage writes.
 * The sum of all nodes should not exceed uint64.
 */
interface CloberSegmentedSegmentTree {
    /**
     * @notice Updates the value at the specified index in the segment tree.
     * @param index The index of the value to update.
     * @param value The value to update with.
     * @return The value that was replaced by the update.
     */
    function update(uint256 index, uint64 value) external returns (uint64);

    /**
     * @notice Gets the value at the specified index in the segment tree.
     * @param index The index of the value to get.
     * @return The value at the specified index in the segment tree.
     */
    function get(uint256 index) external view returns (uint64);

    /**
     * @notice Calculates the sum of all values in the segment tree.
     * @return The sum of all values in the segment tree.
     */
    function total() external view returns (uint256);

    /**
     * @notice Calculates the sum of the values in the segment tree within the specified range.
     * @param left The starting index (inclusive) of the values to sum.
     * @param right The ending index (exclusive) of the values to sum.
     * @return The sum of the values in the segment tree within the specified range.
     */
    function query(uint256 left, uint256 right) external view returns (uint256);
}
