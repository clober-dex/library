import hre from 'hardhat'
import { expect } from 'chai'
import { BigNumber } from 'ethers'

import { DirtyUint64Wrapper, PackedUint256Wrapper } from '../typechain'
import { getSnapshot, randomBigNumber, setSnapshot } from '../utils/misc'

import { encodeCustomError } from './utils'

const { ethers } = hre

describe('DirtyUint64Wrapper Test', () => {
  const MAX_UINT32 = BigNumber.from(2).pow(32).sub(1)
  const MAX_UINT64 = BigNumber.from(2).pow(64).sub(1)
  const MAX_UINT256 = BigNumber.from(2).pow(256).sub(1)
  const FUZZING_NUM = 20
  let dirtyUint64Wrapper: DirtyUint64Wrapper
  let packedLib: PackedUint256Wrapper

  before(async () => {
    dirtyUint64Wrapper = (await (await ethers.getContractFactory('DirtyUint64Wrapper')).deploy()) as DirtyUint64Wrapper
    packedLib = (await (await ethers.getContractFactory('PackedUint256Wrapper')).deploy()) as PackedUint256Wrapper
    await setSnapshot('dirtyUint64Wrapper')
  })

  beforeEach(async () => {
    await getSnapshot('dirtyUint64Wrapper')
    await setSnapshot('dirtyUint64Wrapper')
  })

  it('To be dirty and clean when `cleanUint` is range of `uint64`', async () => {
    for (let i = 0; i < FUZZING_NUM; i++) {
      const cleanUint = randomBigNumber(MAX_UINT64)
      const dirtyUint = await dirtyUint64Wrapper.toDirty(cleanUint)
      expect(dirtyUint).to.be.eq(cleanUint.add(1))
      expect(await dirtyUint64Wrapper.toClean(dirtyUint)).to.be.eq(cleanUint)
    }
  })

  it('To be dirty and clean when `cleanUint` is MAX_UINT64', async () => {
    expect(await dirtyUint64Wrapper.toDirtyUnsafe(MAX_UINT64)).to.be.eq(0)
    await expect(dirtyUint64Wrapper.toDirty(MAX_UINT64)).to.be.revertedWith(
      encodeCustomError('DirtyUint64Error(uint256)', [0], true),
    )
  })

  it('add clean when under `uint64`', async () => {
    for (let i = 0; i < FUZZING_NUM; i++) {
      const current = randomBigNumber(MAX_UINT32)
      const cleanUint = randomBigNumber(MAX_UINT32)
      let expected = current.add(cleanUint)
      if (current.isZero()) {
        expected = expected.add(1)
      }
      expect(await dirtyUint64Wrapper.addClean(current, cleanUint)).to.be.eq(expected)
    }
  })

  it('add clean when out of `uint64`', async () => {
    await expect(dirtyUint64Wrapper.addClean(MAX_UINT64, MAX_UINT64)).to.be.revertedWith(
      encodeCustomError('DirtyUint64Error(uint256)', [0], true),
    )
  })

  it('add dirty when under `uint64`', async () => {
    for (let i = 0; i < FUZZING_NUM; i++) {
      const current = randomBigNumber(MAX_UINT32)
      const dirtyUint = randomBigNumber(MAX_UINT32)
      let expected
      if (current.isZero() && dirtyUint.isZero()) {
        expected = 1
      } else if (current.isZero() || dirtyUint.isZero()) {
        expected = current.add(dirtyUint)
      } else {
        expected = current.add(dirtyUint).sub(1)
      }
      expect(await dirtyUint64Wrapper.addDirty(current, dirtyUint)).to.be.eq(expected)
    }
  })

  it('add dirty when out of `uint64`', async () => {
    await expect(dirtyUint64Wrapper.addDirty(MAX_UINT64, MAX_UINT64)).to.be.revertedWith(
      encodeCustomError('DirtyUint64Error(uint256)', [0], true),
    )
  })

  it('sub clean when cleanUint < current', async () => {
    for (let i = 0; i < FUZZING_NUM; i++) {
      const cleanUint = randomBigNumber(MAX_UINT64.sub(2))
      const current = randomBigNumber(cleanUint.add(1), MAX_UINT64)
      expect(await dirtyUint64Wrapper.subClean(current, cleanUint)).to.be.eq(current.sub(cleanUint))
    }
  })

  it('sub clean when cleanUint and current are zero', async () => {
    expect(await dirtyUint64Wrapper.subClean(0, 0)).to.be.eq(1)
  })

  it('sub clean when cleanUint > current', async () => {
    await expect(dirtyUint64Wrapper.subClean(0, 1)).to.be.revertedWith(
      encodeCustomError('DirtyUint64Error(uint256)', [1], true),
    )
    await expect(dirtyUint64Wrapper.subClean(1, 2)).to.be.revertedWith(
      encodeCustomError('DirtyUint64Error(uint256)', [1], true),
    )
  })

  it('sub dirty when not current < dirtyUint', async () => {
    for (let i = 0; i < FUZZING_NUM; i++) {
      const dirtyUint = randomBigNumber(MAX_UINT64.sub(2))
      const current = randomBigNumber(dirtyUint.add(1), MAX_UINT64)
      if (current.isZero() && dirtyUint.lte(1)) {
        expect(await dirtyUint64Wrapper.subDirty(current, dirtyUint)).to.be.eq(1)
      } else if (dirtyUint.isZero()) {
        expect(await dirtyUint64Wrapper.subDirty(current, dirtyUint)).to.be.eq(current)
      } else {
        expect(await dirtyUint64Wrapper.subDirty(current, dirtyUint)).to.be.eq(current.sub(dirtyUint).add(1))
      }
    }
  })

  it('sub dirty when current < dirtyUint', async () => {
    const current = randomBigNumber(MAX_UINT64.sub(2))
    const dirtyUint = randomBigNumber(current.add(1), MAX_UINT64)
    await expect(dirtyUint64Wrapper.subDirty(current, dirtyUint)).to.be.revertedWith(
      encodeCustomError('DirtyUint64Error(uint256)', [1], true),
    )
  })

  it('sub dirty when current == 0 and dirtyUint >=0', async () => {
    await expect(dirtyUint64Wrapper.subDirty(0, 2)).to.be.revertedWith(
      encodeCustomError('DirtyUint64Error(uint256)', [1], true),
    )
  })

  it('test sum of packed unsafe', async () => {
    for (let i = 0; i < FUZZING_NUM; i++) {
      const packed = randomBigNumber(MAX_UINT256)
      for (let i = 0; i < 4; i++) {
        for (let j = i + 1; j <= 4; j++) {
          let sum = BigNumber.from(0)
          for (let k = i; k < j; k++) {
            sum = sum.add(await dirtyUint64Wrapper.toClean(packedLib.get64(packed, k)))
          }
          if (sum.lte(MAX_UINT64)) {
            expect(await dirtyUint64Wrapper.sumPackedUnsafe(packed, i, j)).to.be.eq(sum)
          }
        }
      }
    }
  })
})
