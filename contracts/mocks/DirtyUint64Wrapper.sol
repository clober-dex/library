// SPDX-License-Identifier: -
// License: https://license.clober.io/LICENSE.pdf

pragma solidity ^0.8.0;

import "../DirtyUint64.sol";
import "../interfaces/CloberDirtyUint64.sol";

contract DirtyUint64Wrapper is CloberDirtyUint64 {
    using DirtyUint64 for uint64;

    function toDirtyUnsafe(uint64 cleanUint) external pure returns (uint64) {
        return cleanUint.toDirtyUnsafe();
    }

    function toDirty(uint64 cleanUint) external pure returns (uint64) {
        return cleanUint.toDirty();
    }

    function toClean(uint64 dirtyUint) external pure returns (uint64) {
        return dirtyUint.toClean();
    }

    function addClean(uint64 current, uint64 cleanUint) external pure returns (uint64) {
        return current.addClean(cleanUint);
    }

    function addDirty(uint64 current, uint64 dirtyUint) external pure returns (uint64) {
        return current.addDirty(dirtyUint);
    }

    function subClean(uint64 current, uint64 cleanUint) external pure returns (uint64) {
        return current.subClean(cleanUint);
    }

    function subDirty(uint64 current, uint64 dirtyUint) external pure returns (uint64) {
        return current.subDirty(dirtyUint);
    }

    function sumPackedUnsafe(
        uint256 packed,
        uint256 from,
        uint256 to
    ) external pure returns (uint64) {
        return DirtyUint64.sumPackedUnsafe(packed, from, to);
    }
}
