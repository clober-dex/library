import hre from 'hardhat'
import { expect } from 'chai'
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers'
import { BigNumber, BigNumberish, ContractFactory } from 'ethers'

import { Create1Wrapper } from '../typechain'
import { getSnapshot, setSnapshot } from '../utils/misc'

const { ethers, network } = hre

describe('Create1Wrapper Test', () => {
  const MAX_UINT64 = BigNumber.from(2).pow(64).sub(1)

  let Create1WrapperFactory: ContractFactory
  let create1Wrapper: Create1Wrapper
  let deployer: SignerWithAddress

  before(async () => {
    Create1WrapperFactory = await ethers.getContractFactory('Create1Wrapper')
    create1Wrapper = (await (
      await Create1WrapperFactory
    ).deploy()) as Create1Wrapper
    ;[, deployer] = await ethers.getSigners()
    await network.provider.send('evm_setAutomine', [false])
    await setSnapshot('create1Wrapper')
  })

  beforeEach(async () => {
    await getSnapshot('create1Wrapper')
    await setSnapshot('create1Wrapper')
  })

  after(async () => {
    await hre.network.provider.send('hardhat_reset')
  })

  const _testComputeAddress = async (
    origin: SignerWithAddress,
    nonce: BigNumberish,
  ) => {
    const expected = await create1Wrapper.computeAddress(origin.address, nonce)

    const generated = (
      await Create1WrapperFactory.connect(origin).deploy({
        nonce: nonce.toString(),
      })
    ).address
    expect(generated).to.be.eq(expected)
  }

  it('testComputeAddress', async () => {
    await _testComputeAddress(deployer, BigNumber.from('0'))
    await _testComputeAddress(deployer, BigNumber.from('1'))
    await _testComputeAddress(deployer, BigNumber.from('0x80'))
    await _testComputeAddress(deployer, BigNumber.from('0x100'))
    await _testComputeAddress(deployer, BigNumber.from('0x10000'))
    await _testComputeAddress(deployer, BigNumber.from('0x1000000'))
    await _testComputeAddress(deployer, BigNumber.from('0x100000000'))
    await _testComputeAddress(deployer, BigNumber.from('0x10000000000'))
    await _testComputeAddress(deployer, BigNumber.from('0x1000000000000'))
    // await _testComputeAddress(deployer, BigNumber.from('0x100000000000000'))
  })

  it('testComputeAddressRevertMaxNonce', async () => {
    await expect(
      create1Wrapper.computeAddress(deployer.address, MAX_UINT64),
    ).to.be.revertedWith('MAX_NONCE')
  })
})
