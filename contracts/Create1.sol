// SPDX-License-Identifier: -
// License: https://license.clober.io/LICENSE.pdf

pragma solidity ^0.8.0;

library Create1 {
    function computeAddress(address origin, uint64 nonce) internal pure returns (address) {
        bytes memory data;

        if (nonce == 0x00) {
            data = abi.encodePacked(bytes1(0xd6), bytes1(0x94), origin, bytes1(0x80));
        } else if (nonce <= 0x7f) {
            data = abi.encodePacked(bytes1(0xd6), bytes1(0x94), origin, bytes1(uint8(nonce)));
        } else if (nonce <= 0xff) {
            data = abi.encodePacked(bytes1(0xd7), bytes1(0x94), origin, bytes1(0x81), uint8(nonce));
        } else if (nonce <= 0xffff) {
            data = abi.encodePacked(bytes1(0xd8), bytes1(0x94), origin, bytes1(0x82), uint16(nonce));
        } else if (nonce <= 0xffffff) {
            data = abi.encodePacked(bytes1(0xd9), bytes1(0x94), origin, bytes1(0x83), uint24(nonce));
        } else if (nonce <= 0xffffffff) {
            data = abi.encodePacked(bytes1(0xda), bytes1(0x94), origin, bytes1(0x84), uint32(nonce));
        } else if (nonce <= 0xffffffffff) {
            data = abi.encodePacked(bytes1(0xdb), bytes1(0x94), origin, bytes1(0x85), uint40(nonce));
        } else if (nonce <= 0xffffffffffff) {
            data = abi.encodePacked(bytes1(0xdc), bytes1(0x94), origin, bytes1(0x86), uint48(nonce));
        } else if (nonce <= 0xffffffffffffff) {
            data = abi.encodePacked(bytes1(0xdd), bytes1(0x94), origin, bytes1(0x87), uint56(nonce));
        } else if (nonce < 0xffffffffffffffff) {
            data = abi.encodePacked(bytes1(0xde), bytes1(0x94), origin, bytes1(0x88), nonce);
        } else {
            // Cannot deploy contract when the nonce is type(uint64).max
            revert("MAX_NONCE");
        }
        return address(uint160(uint256(keccak256(data))));
    }
}
