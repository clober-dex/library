// SPDX-License-Identifier: -
// License: https://license.clober.io/LICENSE.pdf

pragma solidity ^0.8.0;

import "../../contracts/mocks/SignificantBitWrapper.sol";
import "forge-std/Test.sol";

contract SignificantBitTest is Test {
    SignificantBitWrapper wrapper;

    function setUp() public {
        wrapper = new SignificantBitWrapper();
    }

    function test() public {
        vm.expectRevert();
        wrapper.leastSignificantBit(0);
        // powers of 2
        for (uint256 i = 0; i < 256; ++i) {
            assertEq(wrapper.leastSignificantBit(2**i), i);
        }
        assertEq(wrapper.leastSignificantBit(2**256 - 1), 0);
    }
}
