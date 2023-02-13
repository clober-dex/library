// SPDX-License-Identifier: -
// License: https://license.clober.io/LICENSE.pdf

pragma solidity ^0.8.0;

/**
 * @title Create1
 * @notice Utility functions regarding the vanilla `CREATE` operation.
 */
interface CloberCreate1 {
    /**
     * @notice Computes the address of the contract with the origin address and nonce value.
     * @param origin The origin address from which the contract address is derived.
     * @param nonce The nonce value to use in the contract address computation.
     * @return The computed contract address.
     */
    function computeAddress(address origin, uint64 nonce) external pure returns (address);
}
