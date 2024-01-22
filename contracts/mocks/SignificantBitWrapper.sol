// SPDX-License-Identifier: -
// License: https://license.clober.io/LICENSE.pdf

pragma solidity ^0.8.0;

import "../SignificantBit.sol";

contract SignificantBitWrapper {
    using SignificantBit for uint256;

    function leastSignificantBit(uint256 x) external pure returns (uint8) {
        return x.leastSignificantBit();
    }

    function mostSignificantBit(uint256 x) external pure returns (uint8) {
        return x.mostSignificantBit();
    }

}
