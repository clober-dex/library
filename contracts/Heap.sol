// SPDX-License-Identifier: -
// License: https://license.clober.io/LICENSE.pdf

pragma solidity ^0.8.0;

import "./SignificantBit.sol";

library Heap {
    using SignificantBit for uint256;

    error HeapError(uint256 errorCode);
    uint256 public constant EMPTY_ERROR = 0;
    uint256 public constant ALREADY_EXISTS_ERROR = 1;

    struct Core {
        uint256 bitmap;
        mapping(uint256 => uint256) bitmapMapping;
    }

    function has(Core storage core, uint24 value) internal view returns (bool) {
        (uint256 wordIndex, uint256 bitIndex) = _split(value);
        uint256 mask = 1 << bitIndex;
        return core.bitmapMapping[wordIndex] & mask == mask;
    }

    function isEmpty(Core storage core) internal view returns (bool) {
        return core.bitmap == 0;
    }

    function _split(uint24 value) private pure returns (uint256 wordIndex, uint8 bitIndex) {
        assembly {
            bitIndex := value
            wordIndex := shr(8, value)
        }
    }

    function _root(Core storage core) private view returns (uint256 wordIndex, uint256 bitIndex) {
        wordIndex = core.bitmap.leastSignificantBit();
        wordIndex = (wordIndex << 8) | (core.bitmapMapping[~wordIndex].leastSignificantBit());
        uint256 word = core.bitmapMapping[wordIndex];
        bitIndex = word.leastSignificantBit();
    }

    function root(Core storage core) internal view returns (uint24) {
        if (isEmpty(core)) revert MinBitMapError(EMPTY_ERROR);

        (uint256 wordIndex, uint256 bitIndex) = _root(core);
        return uint24((wordIndex << 8) | bitIndex);
    }

    function push(Core storage core, uint24 value) internal {
        (uint256 wordIndex, uint256 bitIndex) = _split(value);
        uint256 mask = 1 << bitIndex;
        uint256 word = core.bitmapMapping[wordIndex];
        if (word & mask > 0) {
            revert HeapError(ALREADY_EXISTS_ERROR);
        }

        core.bitmapMapping[wordIndex] = word | mask;
        if (word == 0) {
            mask = 1 << (wordIndex & 0xff);
            wordIndex = wordIndex >> 8;
            core.bitmap = core.bitmap | (1 << wordIndex);
            wordIndex = ~wordIndex;
            core.bitmapMapping[wordIndex] = core.bitmapMapping[wordIndex] | mask;
        }
    }

    function pop(Core storage core) internal {
        if (isEmpty(core)) revert HeapError(EMPTY_ERROR);

        (uint256 wordIndex, uint256 bitIndex) = _root(core);
        uint256 mask = 1 << bitIndex;
        uint256 word = core.bitmapMapping[wordIndex];

        core.bitmapMapping[wordIndex] = word & (~mask);
        if (word == mask) {
            mask = 1 << (wordIndex & 0xff);
            wordIndex = ~(wordIndex >> 8);
            word = core.bitmapMapping[wordIndex];

            core.bitmapMapping[wordIndex] = word & (~mask);
            if (mask == word) {
                mask = 1 << (~wordIndex);
                core.bitmap = core.bitmap & (~mask);
            }
        }
    }

    function getNextMinValue(Core storage core, uint24 value) internal view returns (uint24) {
        (uint256 wordIndex, uint256 bitIndex) = _split(value);
        uint256 word = ((type(uint256).max >> bitIndex) << bitIndex) & core.bitmapMapping[wordIndex];
        if (word == 0) {
            uint256 head = wordIndex >> 8;
            uint256 middle = wordIndex & 0xff;
            word = ((type(uint256).max >> middle) << middle) & core.bitmapMapping[~head];
            if (word == 0) {
                word = ((type(uint256).max >> head) << head) & core.bitmap;
                if (word == 0) {
                    revert HeapError(EMPTY_ERROR);
                }
                head = word.leastSignificantBit();
            }
            middle = word.leastSignificantBit();
            wordIndex = (head << 8) | middle;
        }
        bitIndex = word.leastSignificantBit();
        return uint24((wordIndex << 8) | bitIndex);
    }
}
