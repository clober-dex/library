// SPDX-License-Identifier: -
// License: https://license.clober.io/LICENSE.pdf

pragma solidity ^0.8.0;

/**
 * 🐙🐙🐙🐙🐙🐙🐙🐙🐙🐙🐙🐙🐙🐙🐙🐙
 * 
 *             Octopus Heap
 *                by Clober
 * 
 *       ⢀⣀⣠⣀⣀⡀
 *     ⣠⣾⣿⣿⣿⣿⣿⣿⣷⣦⡀
 *    ⢠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡀   ⣠⣶⣾⣷⣶⣄
 *    ⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧  ⢰⣿⠟⠉⠻⣿⣿⣷
 *    ⠈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⢷⣄⠘⠿   ⢸⣿⣿⡆
 *     ⠈⠿⣿⣿⣿⣿⣿⣀⣸⣿⣷⣤⣴⠟    ⢀⣼⣿⣿⠁
 *       ⠈⠙⣛⣿⣿⣿⣿⣿⣿⣿⣿⣦⣀⣀⣀⣴⣾⣿⣿⡟
 *    ⢀⣠⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠋⣠⣤⣀
 *   ⣴⣿⣿⣿⠿⠟⠛⠛⢛⣿⣿⣿⣿⣿⣿⣧⡈⠉⠁   ⠈⠉⢻⣿⣧
 *  ⣼⣿⣿⠋    ⢠⣾⣿⣿⠟⠉⠻⣿⣿⣿⣦⣄     ⣸⣿⣿⠃
 *  ⣿⣿⡇     ⣿⣿⡿⠃   ⠈⠛⢿⣿⣿⣿⣿⣶⣿⣿⣿⡿⠋
 *  ⢿⣿⣧⡀ ⣶⣄⠘⣿⣿⡇  ⠠⠶⣿⣶⡄⠈⠙⠛⠻⠟⠛⠛⠁
 *  ⠈⠻⣿⣿⣿⣿⠏ ⢻⣿⣿⣄    ⣸⣿⡇
 *            ⠻⣿⣿⣿⣶⣾⣿⣿⠃
 *             ⠈⠙⠛⠛⠛⠋
 * 
 * 🐙🐙🐙🐙🐙🐙🐙🐙🐙🐙🐙🐙🐙🐙🐙🐙
 */

/**
 * @title Octopus Heap
 * @notice Heap data structure that can hold up to 256 uint16 values.
 * Each value is stored by having the quotient divided by 2^8 added to the heap,
 * and the remainder expressed as a flag on a bitmap.
 */
interface CloberOctopusHeap {
    /**
     * @notice Initializes the heap.
     * @dev Must be called before use.
     */
    function init() external;

    /**
     * @notice Checks if the specified value is present in the heap.
     * @param value The value to check for.
     * @return True if the value is present in the heap, false otherwise.
     */
    function has(uint16 value) external view returns (bool);

    /**
     * @notice Checks if the heap is empty.
     * @return True if the heap is empty, false otherwise.
     */
    function isEmpty() external view returns (bool);

    /**
     * @notice Pushes a value onto the heap.
     * @param value The value to push onto the heap.
     */
    function push(uint16 value) external;

    /**
     * @notice Pops a value from the heap.
     */
    function pop() external;

    /**
     * @notice Returns the root value of the heap.
     * @return The root value of the heap.
     */
    function root() external view returns (uint16);
}
