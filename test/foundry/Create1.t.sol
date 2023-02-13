// SPDX-License-Identifier: -
// License: https://license.clober.io/LICENSE.pdf

pragma solidity ^0.8.0;

import "forge-std/Test.sol";

import "../../contracts/mocks/Create1Wrapper.sol";

contract Create1Test is Test {
    Create1Wrapper create1Wrapper;

    function setUp() public {
        create1Wrapper = new Create1Wrapper();
    }

    function testComputeAddress() public {
        address deployer = address(123);
        _testComputeAddress(deployer, 0);
        _testComputeAddress(deployer, 1);
        _testComputeAddress(deployer, 0x80);
        _testComputeAddress(deployer, 0x100);
        _testComputeAddress(deployer, 0x10000);
        _testComputeAddress(deployer, 0x1000000);
        _testComputeAddress(deployer, 0x100000000);
        _testComputeAddress(deployer, 0x10000000000);
        _testComputeAddress(deployer, 0x1000000000000);
        _testComputeAddress(deployer, 0x100000000000000);
    }

    function testComputeAddressRevertMaxNonce() public {
        vm.expectRevert(bytes("MAX_NONCE"));
        create1Wrapper.computeAddress(address(123), type(uint64).max);
    }

    function testComputeAddressFuzz(uint64 nonce) public {
        vm.assume(nonce < type(uint64).max);
        address deployer = address(123);
        _testComputeAddress(deployer, nonce);
    }

    function _testComputeAddress(address origin, uint64 nonce) internal {
        if (nonce > vm.getNonce(origin)) {
            vm.setNonce(origin, nonce);
        }
        address expected = create1Wrapper.computeAddress(origin, nonce);
        vm.prank(origin);
        address generated = address(new Create1Wrapper());
        assertEq(expected, generated, vm.toString(nonce));
    }
}
