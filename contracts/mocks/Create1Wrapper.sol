// SPDX-License-Identifier: -
// License: https://license.clober.io/LICENSE.pdf

pragma solidity ^0.8.0;

import "../Create1.sol";
import "../interfaces/CloberCreate1.sol";

contract Create1Wrapper is CloberCreate1 {
    function computeAddress(address origin, uint64 nonce) external pure returns (address) {
        return Create1.computeAddress(origin, nonce);
    }
}
