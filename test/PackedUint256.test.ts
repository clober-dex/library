import { ethers } from 'hardhat'
import { BigNumber } from 'ethers'
import { expect } from 'chai'

import { PackedUint256Wrapper } from '../typechain'
import { getSnapshot, randomBigNumber, setSnapshot } from '../utils/misc'

import { encodeCustomError } from './utils'

describe('PackedUint256 Test', () => {
  const MAX_UINT8 = BigNumber.from(2).pow(8).sub(1)
  const MAX_UINT16 = BigNumber.from(2).pow(16).sub(1)
  const MAX_UINT32 = BigNumber.from(2).pow(32).sub(1)
  const MAX_UINT64 = BigNumber.from(2).pow(64).sub(1)
  const FUZZING_NUM = 20
  let packedLib: PackedUint256Wrapper
  before(async () => {
    packedLib = (await (
      await ethers.getContractFactory('PackedUint256Wrapper')
    ).deploy()) as PackedUint256Wrapper
    await setSnapshot('PackedUint256')
  })

  beforeEach(async () => {
    await getSnapshot('PackedUint256')
    await setSnapshot('PackedUint256')
  })

  describe('#get8Unsafe()', () => {
    for (let i = 0; i < FUZZING_NUM; i++) {
      const values: BigNumber[] = []
      let packed = BigNumber.from(0)
      for (let j = 0; j < 32; j++) {
        const value = randomBigNumber(MAX_UINT8)
        values.push(value)
        packed = packed.add(value.shl(j * 8))
      }
      it(packed.toHexString(), async () => {
        const promises: Promise<number>[] = []
        for (let j = 0; j < 32; j++) {
          promises.push(packedLib.get8Unsafe(packed, j))
        }
        const slices = await Promise.all(promises)
        slices.forEach((s, k) => {
          expect(s).to.be.equal(values[k], `index ${k}`)
        })
      })
    }
  })

  describe('#get8()', () => {
    it('should revert invalid index', async () => {
      await expect(packedLib.get8(randomBigNumber(), 32)).to.be.revertedWith(
        encodeCustomError('PackedUint256Error(uint256)', [0], true),
      )
    })

    for (let i = 0; i < FUZZING_NUM; i++) {
      const values: BigNumber[] = []
      let packed = BigNumber.from(0)
      for (let j = 0; j < 32; j++) {
        const value = randomBigNumber(MAX_UINT8)
        values.push(value)
        packed = packed.add(value.shl(j * 8))
      }
      it(packed.toHexString(), async () => {
        const promises: Promise<number>[] = []
        for (let j = 0; j < 32; j++) {
          promises.push(packedLib.get8(packed, j))
        }
        const slices = await Promise.all(promises)
        slices.forEach((s, k) => {
          expect(s).to.be.equal(values[k], `index ${k}`)
        })
      })
    }
  })

  describe('#get16Unsafe()', () => {
    for (let i = 0; i < FUZZING_NUM; i++) {
      const values: BigNumber[] = []
      let packed = BigNumber.from(0)
      for (let j = 0; j < 16; j++) {
        const value = randomBigNumber(MAX_UINT16)
        values.push(value)
        packed = packed.add(value.shl(j * 16))
      }
      it(packed.toHexString(), async () => {
        const promises: Promise<number>[] = []
        for (let j = 0; j < 16; j++) {
          promises.push(packedLib.get16Unsafe(packed, j))
        }
        const slices = await Promise.all(promises)
        slices.forEach((s, k) => {
          expect(s).to.be.equal(values[k], `index ${k}`)
        })
      })
    }
  })

  describe('#get16()', () => {
    it('should revert invalid index', async () => {
      await expect(packedLib.get16(randomBigNumber(), 16)).to.be.revertedWith(
        encodeCustomError('PackedUint256Error(uint256)', [1], true),
      )
    })

    for (let i = 0; i < FUZZING_NUM; i++) {
      const values: BigNumber[] = []
      let packed = BigNumber.from(0)
      for (let j = 0; j < 16; j++) {
        const value = randomBigNumber(MAX_UINT16)
        values.push(value)
        packed = packed.add(value.shl(j * 16))
      }
      it(packed.toHexString(), async () => {
        const promises: Promise<number>[] = []
        for (let j = 0; j < 16; j++) {
          promises.push(packedLib.get16(packed, j))
        }
        const slices = await Promise.all(promises)
        slices.forEach((s, k) => {
          expect(s).to.be.equal(values[k], `index ${k}`)
        })
      })
    }
  })

  describe('#get32Unsafe()', () => {
    for (let i = 0; i < FUZZING_NUM; i++) {
      const values: BigNumber[] = []
      let packed = BigNumber.from(0)
      for (let j = 0; j < 8; j++) {
        const value = randomBigNumber(MAX_UINT32)
        values.push(value)
        packed = packed.add(value.shl(j * 32))
      }
      it(packed.toHexString(), async () => {
        const promises: Promise<number>[] = []
        for (let j = 0; j < 8; j++) {
          promises.push(packedLib.get32Unsafe(packed, j))
        }
        const slices = await Promise.all(promises)
        slices.forEach((s, k) => {
          expect(s).to.be.equal(values[k], `index ${k}`)
        })
      })
    }
  })

  describe('#get32()', () => {
    it('should revert invalid index', async () => {
      await expect(packedLib.get32(randomBigNumber(), 8)).to.be.revertedWith(
        encodeCustomError('PackedUint256Error(uint256)', [2], true),
      )
    })

    for (let i = 0; i < FUZZING_NUM; i++) {
      const values: BigNumber[] = []
      let packed = BigNumber.from(0)
      for (let j = 0; j < 8; j++) {
        const value = randomBigNumber(MAX_UINT32)
        values.push(value)
        packed = packed.add(value.shl(j * 32))
      }
      it(packed.toHexString(), async () => {
        const promises: Promise<number>[] = []
        for (let j = 0; j < 8; j++) {
          promises.push(packedLib.get32(packed, j))
        }
        const slices = await Promise.all(promises)
        slices.forEach((s, k) => {
          expect(s).to.be.equal(values[k], `index ${k}`)
        })
      })
    }
  })

  describe('#get64Unsafe()', () => {
    for (let i = 0; i < FUZZING_NUM; i++) {
      const values: BigNumber[] = []
      let packed = BigNumber.from(0)
      for (let j = 0; j < 4; j++) {
        const value = randomBigNumber(MAX_UINT64)
        values.push(value)
        packed = packed.add(value.shl(j * 64))
      }
      it(packed.toHexString(), async () => {
        const promises: Promise<BigNumber>[] = []
        for (let j = 0; j < 4; j++) {
          promises.push(packedLib.get64Unsafe(packed, j))
        }
        const slices = await Promise.all(promises)
        slices.forEach((s, k) => {
          expect(s.toString()).to.be.equal(values[k].toString(), `index ${k}`)
        })
      })
    }
  })

  describe('#get64()', () => {
    it('should revert invalid index', async () => {
      await expect(packedLib.get64(randomBigNumber(), 4)).to.be.revertedWith(
        encodeCustomError('PackedUint256Error(uint256)', [3], true),
      )
    })

    for (let i = 0; i < FUZZING_NUM; i++) {
      const values: BigNumber[] = []
      let packed = BigNumber.from(0)
      for (let j = 0; j < 4; j++) {
        const value = randomBigNumber(MAX_UINT64)
        values.push(value)
        packed = packed.add(value.shl(j * 64))
      }
      it(packed.toHexString(), async () => {
        const promises: Promise<BigNumber>[] = []
        for (let j = 0; j < 4; j++) {
          promises.push(packedLib.get64(packed, j))
        }
        const slices = await Promise.all(promises)
        slices.forEach((s, k) => {
          expect(s.toString()).to.be.equal(values[k].toString(), `index ${k}`)
        })
      })
    }
  })

  describe('#add8Unsafe()', () => {
    for (let i = 0; i < FUZZING_NUM; i++) {
      const packed = randomBigNumber()
      it(packed.toHexString(), async () => {
        const promises: Promise<number>[] = []
        for (let j = 0; j < 32; j++) {
          promises.push(packedLib.get8Unsafe(packed, j))
        }
        const slices = await Promise.all(promises)
        for (let j = 0; j < 32; j++) {
          const add = randomBigNumber(MAX_UINT8.sub(slices[j]))
          const expected = packed.add(add.shl(j * 8))
          const added = await packedLib.add8Unsafe(packed, j, add)
          expect(added.toHexString()).to.be.equal(
            expected.toHexString(),
            `index ${j}`,
          )
        }
      })
    }
  })

  describe('#add8()', () => {
    it('should revert invalid index', async () => {
      await expect(
        packedLib.add8(randomBigNumber(), 32, randomBigNumber(MAX_UINT8)),
      ).to.be.revertedWith(
        encodeCustomError('PackedUint256Error(uint256)', [0], true),
      )
    })

    for (let i = 0; i < FUZZING_NUM; i++) {
      const packed = randomBigNumber()
      it(packed.toHexString(), async () => {
        const promises: Promise<number>[] = []
        for (let j = 0; j < 32; j++) {
          promises.push(packedLib.get8Unsafe(packed, j))
        }
        const slices = await Promise.all(promises)
        for (let j = 0; j < 32; j++) {
          const add = randomBigNumber(MAX_UINT8.sub(slices[j]))
          const expected = packed.add(add.shl(j * 8))
          const added = await packedLib.add8(packed, j, add)
          expect(added.toHexString()).to.be.equal(
            expected.toHexString(),
            `index ${j}`,
          )
          const overAdded = MAX_UINT8.sub(slices[j]).add(1)
          await expect(packedLib.add8(packed, j, overAdded)).to.be.reverted
        }
      })
    }
  })

  describe('#add16Unsafe()', () => {
    for (let i = 0; i < FUZZING_NUM; i++) {
      const packed = randomBigNumber()
      it(packed.toHexString(), async () => {
        const promises: Promise<number>[] = []
        for (let j = 0; j < 16; j++) {
          promises.push(packedLib.get16Unsafe(packed, j))
        }
        const slices = await Promise.all(promises)
        for (let j = 0; j < 16; j++) {
          const add = randomBigNumber(MAX_UINT16.sub(slices[j]))
          const expected = packed.add(add.shl(j * 16))
          const added = await packedLib.add16Unsafe(packed, j, add)
          expect(added.toHexString()).to.be.equal(
            expected.toHexString(),
            `index ${j}`,
          )
        }
      })
    }
  })

  describe('#add16()', () => {
    it('should revert invalid index', async () => {
      await expect(
        packedLib.add16(randomBigNumber(), 16, randomBigNumber(MAX_UINT16)),
      ).to.be.revertedWith(
        encodeCustomError('PackedUint256Error(uint256)', [1], true),
      )
    })

    for (let i = 0; i < FUZZING_NUM; i++) {
      const packed = randomBigNumber()
      it(packed.toHexString(), async () => {
        const promises: Promise<number>[] = []
        for (let j = 0; j < 16; j++) {
          promises.push(packedLib.get16Unsafe(packed, j))
        }
        const slices = await Promise.all(promises)
        for (let j = 0; j < 16; j++) {
          const add = randomBigNumber(MAX_UINT16.sub(slices[j]))
          const expected = packed.add(add.shl(j * 16))
          const added = await packedLib.add16(packed, j, add)
          expect(added.toHexString()).to.be.equal(
            expected.toHexString(),
            `index ${j}`,
          )
          const overAdded = MAX_UINT16.sub(slices[j]).add(1)
          await expect(packedLib.add16(packed, j, overAdded)).to.be.reverted
        }
      })
    }
  })

  describe('#add32Unsafe()', () => {
    for (let i = 0; i < FUZZING_NUM; i++) {
      const packed = randomBigNumber()
      it(packed.toHexString(), async () => {
        const promises: Promise<number>[] = []
        for (let j = 0; j < 8; j++) {
          promises.push(packedLib.get32Unsafe(packed, j))
        }
        const slices = await Promise.all(promises)
        for (let j = 0; j < 8; j++) {
          const add = randomBigNumber(MAX_UINT32.sub(slices[j]))
          const expected = packed.add(add.shl(j * 32))
          const added = await packedLib.add32Unsafe(packed, j, add)
          expect(added.toHexString()).to.be.equal(
            expected.toHexString(),
            `index ${j}`,
          )
        }
      })
    }
  })

  describe('#add32()', () => {
    it('should revert invalid index', async () => {
      await expect(
        packedLib.add32(randomBigNumber(), 8, randomBigNumber(MAX_UINT32)),
      ).to.be.revertedWith(
        encodeCustomError('PackedUint256Error(uint256)', [2], true),
      )
    })

    for (let i = 0; i < FUZZING_NUM; i++) {
      const packed = randomBigNumber()
      it(packed.toHexString(), async () => {
        const promises: Promise<number>[] = []
        for (let j = 0; j < 8; j++) {
          promises.push(packedLib.get32Unsafe(packed, j))
        }
        const slices = await Promise.all(promises)
        for (let j = 0; j < 8; j++) {
          const add = randomBigNumber(MAX_UINT32.sub(slices[j]))
          const expected = packed.add(add.shl(j * 32))
          const added = await packedLib.add32(packed, j, add)
          expect(added.toHexString()).to.be.equal(
            expected.toHexString(),
            `index ${j}`,
          )
          const overAdded = MAX_UINT32.sub(slices[j]).add(1)
          await expect(packedLib.add32(packed, j, overAdded)).to.be.reverted
        }
      })
    }
  })

  describe('#add64Unsafe()', () => {
    for (let i = 0; i < FUZZING_NUM; i++) {
      const packed = randomBigNumber()
      it(packed.toHexString(), async () => {
        const promises: Promise<BigNumber>[] = []
        for (let j = 0; j < 4; j++) {
          promises.push(packedLib.get64Unsafe(packed, j))
        }
        const slices = await Promise.all(promises)
        for (let j = 0; j < 4; j++) {
          const add = randomBigNumber(MAX_UINT64.sub(slices[j]))
          const expected = packed.add(add.shl(j * 64))
          const added = await packedLib.add64Unsafe(packed, j, add)
          expect(added.toHexString()).to.be.equal(
            expected.toHexString(),
            `index ${j}`,
          )
        }
      })
    }
  })

  describe('#add64()', () => {
    it('should revert invalid index', async () => {
      await expect(
        packedLib.add64(randomBigNumber(), 4, randomBigNumber(MAX_UINT64)),
      ).to.be.revertedWith(
        encodeCustomError('PackedUint256Error(uint256)', [3], true),
      )
    })

    for (let i = 0; i < FUZZING_NUM; i++) {
      const packed = randomBigNumber()
      it(packed.toHexString(), async () => {
        const promises: Promise<BigNumber>[] = []
        for (let j = 0; j < 4; j++) {
          promises.push(packedLib.get64Unsafe(packed, j))
        }
        const slices = await Promise.all(promises)
        for (let j = 0; j < 4; j++) {
          const add = randomBigNumber(MAX_UINT64.sub(slices[j]))
          const expected = packed.add(add.shl(j * 64))
          const added = await packedLib.add64(packed, j, add)
          expect(added.toHexString()).to.be.equal(
            expected.toHexString(),
            `index ${j}`,
          )
          const overAdded = MAX_UINT64.sub(slices[j]).add(1)
          await expect(packedLib.add64(packed, j, overAdded)).to.be.reverted
        }
      })
    }
  })

  describe('#sub8Unsafe()', () => {
    for (let i = 0; i < FUZZING_NUM; i++) {
      const packed = randomBigNumber()
      it(packed.toHexString(), async () => {
        const promises: Promise<number>[] = []
        for (let j = 0; j < 32; j++) {
          promises.push(packedLib.get8Unsafe(packed, j))
        }
        const slices = await Promise.all(promises)
        for (let j = 0; j < 32; j++) {
          const sub = randomBigNumber(slices[j])
          const expected = packed.sub(sub.shl(j * 8))
          const subbed = await packedLib.sub8Unsafe(packed, j, sub)
          expect(subbed.toHexString()).to.be.equal(
            expected.toHexString(),
            `index ${j}`,
          )
        }
      })
    }
  })

  describe('#sub8()', () => {
    it('should revert invalid index', async () => {
      await expect(
        packedLib.sub8(randomBigNumber(), 32, randomBigNumber(MAX_UINT8)),
      ).to.be.revertedWith(
        encodeCustomError('PackedUint256Error(uint256)', [0], true),
      )
    })

    for (let i = 0; i < FUZZING_NUM; i++) {
      const packed = randomBigNumber()
      it(packed.toHexString(), async () => {
        const promises: Promise<number>[] = []
        for (let j = 0; j < 32; j++) {
          promises.push(packedLib.get8Unsafe(packed, j))
        }
        const slices = await Promise.all(promises)
        for (let j = 0; j < 32; j++) {
          const sub = randomBigNumber(slices[j])
          const expected = packed.sub(sub.shl(j * 8))
          const subbed = await packedLib.sub8(packed, j, sub)
          expect(subbed.toHexString()).to.be.equal(
            expected.toHexString(),
            `index ${j}`,
          )
          const overSubbed = slices[j] + 1
          await expect(packedLib.sub8(packed, j, overSubbed)).to.be.reverted
        }
      })
    }
  })

  describe('#sub16Unsafe()', () => {
    for (let i = 0; i < FUZZING_NUM; i++) {
      const packed = randomBigNumber()
      it(packed.toHexString(), async () => {
        const promises: Promise<number>[] = []
        for (let j = 0; j < 16; j++) {
          promises.push(packedLib.get16Unsafe(packed, j))
        }
        const slices = await Promise.all(promises)
        for (let j = 0; j < 16; j++) {
          const sub = randomBigNumber(slices[j])
          const expected = packed.sub(sub.shl(j * 16))
          const subbed = await packedLib.sub16Unsafe(packed, j, sub)
          expect(subbed.toHexString()).to.be.equal(
            expected.toHexString(),
            `index ${j}`,
          )
        }
      })
    }
  })

  describe('#sub16()', () => {
    it('should revert invalid index', async () => {
      await expect(
        packedLib.sub16(randomBigNumber(), 16, randomBigNumber(MAX_UINT16)),
      ).to.be.revertedWith(
        encodeCustomError('PackedUint256Error(uint256)', [1], true),
      )
    })

    for (let i = 0; i < FUZZING_NUM; i++) {
      const packed = randomBigNumber()
      it(packed.toHexString(), async () => {
        const promises: Promise<number>[] = []
        for (let j = 0; j < 16; j++) {
          promises.push(packedLib.get16Unsafe(packed, j))
        }
        const slices = await Promise.all(promises)
        for (let j = 0; j < 16; j++) {
          const sub = randomBigNumber(slices[j])
          const expected = packed.sub(sub.shl(j * 16))
          const subbed = await packedLib.sub16(packed, j, sub)
          expect(subbed.toHexString()).to.be.equal(
            expected.toHexString(),
            `index ${j}`,
          )
          const overSubbed = slices[j] + 1
          await expect(packedLib.sub16(packed, j, overSubbed)).to.be.reverted
        }
      })
    }
  })

  describe('#sub32Unsafe()', () => {
    for (let i = 0; i < FUZZING_NUM; i++) {
      const packed = randomBigNumber()
      it(packed.toHexString(), async () => {
        const promises: Promise<number>[] = []
        for (let j = 0; j < 8; j++) {
          promises.push(packedLib.get32Unsafe(packed, j))
        }
        const slices = await Promise.all(promises)
        for (let j = 0; j < 8; j++) {
          const sub = randomBigNumber(slices[j])
          const expected = packed.sub(sub.shl(j * 32))
          const subbed = await packedLib.sub32Unsafe(packed, j, sub)
          expect(subbed.toHexString()).to.be.equal(
            expected.toHexString(),
            `index ${j}`,
          )
        }
      })
    }
  })

  describe('#sub32()', () => {
    it('should revert invalid index', async () => {
      await expect(
        packedLib.sub32(randomBigNumber(), 8, randomBigNumber(MAX_UINT32)),
      ).to.be.revertedWith(
        encodeCustomError('PackedUint256Error(uint256)', [2], true),
      )
    })

    for (let i = 0; i < FUZZING_NUM; i++) {
      const packed = randomBigNumber()
      it(packed.toHexString(), async () => {
        const promises: Promise<number>[] = []
        for (let j = 0; j < 8; j++) {
          promises.push(packedLib.get32Unsafe(packed, j))
        }
        const slices = await Promise.all(promises)
        for (let j = 0; j < 8; j++) {
          const sub = randomBigNumber(slices[j])
          const expected = packed.sub(sub.shl(j * 32))
          const subbed = await packedLib.sub32(packed, j, sub)
          expect(subbed.toHexString()).to.be.equal(
            expected.toHexString(),
            `index ${j}`,
          )
          const overSubbed = slices[j] + 1
          await expect(packedLib.sub32(packed, j, overSubbed)).to.be.reverted
        }
      })
    }
  })

  describe('#sub64Unsafe()', () => {
    for (let i = 0; i < FUZZING_NUM; i++) {
      const packed = randomBigNumber()
      it(packed.toHexString(), async () => {
        const promises: Promise<BigNumber>[] = []
        for (let j = 0; j < 4; j++) {
          promises.push(packedLib.get64Unsafe(packed, j))
        }
        const slices = await Promise.all(promises)
        for (let j = 0; j < 4; j++) {
          const sub = randomBigNumber(slices[j])
          const expected = packed.sub(sub.shl(j * 64))
          const subbed = await packedLib.sub64Unsafe(packed, j, sub)
          expect(subbed.toHexString()).to.be.equal(
            expected.toHexString(),
            `index ${j}`,
          )
        }
      })
    }
  })

  describe('#sub64()', () => {
    it('should revert invalid index', async () => {
      await expect(
        packedLib.sub64(randomBigNumber(), 8, randomBigNumber(MAX_UINT64)),
      ).to.be.revertedWith(
        encodeCustomError('PackedUint256Error(uint256)', [3], true),
      )
    })

    for (let i = 0; i < FUZZING_NUM; i++) {
      const packed = randomBigNumber()
      it(packed.toHexString(), async () => {
        const promises: Promise<BigNumber>[] = []
        for (let j = 0; j < 4; j++) {
          promises.push(packedLib.get64Unsafe(packed, j))
        }
        const slices = await Promise.all(promises)
        for (let j = 0; j < 4; j++) {
          const sub = randomBigNumber(slices[j])
          const expected = packed.sub(sub.shl(j * 64))
          const subbed = await packedLib.sub64(packed, j, sub)
          expect(subbed.toHexString()).to.be.equal(
            expected.toHexString(),
            `index ${j}`,
          )
          const overSubbed = slices[j].add(1)
          await expect(packedLib.sub64(packed, j, overSubbed)).to.be.reverted
        }
      })
    }
  })

  describe('#update8Unsafe()', () => {
    for (let i = 0; i < FUZZING_NUM; i++) {
      const packed = randomBigNumber()
      it(packed.toHexString(), async () => {
        for (let j = 0; j < 32; j++) {
          const value = randomBigNumber(MAX_UINT8)
          const ret = await packedLib.update8Unsafe(packed, j, value)
          expect(await packedLib.get8Unsafe(ret, j)).to.be.equal(
            value,
            `index ${j}`,
          )
        }
      })
    }
  })

  describe('#update8()', () => {
    it('should revert invalid index', async () => {
      await expect(
        packedLib.update8(randomBigNumber(), 32, randomBigNumber(MAX_UINT8)),
      ).to.be.revertedWith(
        encodeCustomError('PackedUint256Error(uint256)', [0], true),
      )
    })

    for (let i = 0; i < FUZZING_NUM; i++) {
      const packed = randomBigNumber()
      it(packed.toHexString(), async () => {
        for (let j = 0; j < 32; j++) {
          const value = randomBigNumber(MAX_UINT8)
          const ret = await packedLib.update8(packed, j, value)
          expect(await packedLib.get8Unsafe(ret, j)).to.be.equal(
            value,
            `index ${j}`,
          )
        }
      })
    }
  })

  describe('#update16Unsafe()', () => {
    for (let i = 0; i < FUZZING_NUM; i++) {
      const packed = randomBigNumber()
      it(packed.toHexString(), async () => {
        for (let j = 0; j < 16; j++) {
          const value = randomBigNumber(MAX_UINT16)
          const ret = await packedLib.update16Unsafe(packed, j, value)
          expect(await packedLib.get16Unsafe(ret, j)).to.be.equal(
            value,
            `index ${j}`,
          )
        }
      })
    }
  })

  describe('#update16()', () => {
    it('should revert invalid index', async () => {
      await expect(
        packedLib.update16(randomBigNumber(), 16, randomBigNumber(MAX_UINT16)),
      ).to.be.revertedWith(
        encodeCustomError('PackedUint256Error(uint256)', [1], true),
      )
    })

    for (let i = 0; i < FUZZING_NUM; i++) {
      const packed = randomBigNumber()
      it(packed.toHexString(), async () => {
        for (let j = 0; j < 16; j++) {
          const value = randomBigNumber(MAX_UINT16)
          const ret = await packedLib.update16(packed, j, value)
          expect(await packedLib.get16Unsafe(ret, j)).to.be.equal(
            value,
            `index ${j}`,
          )
        }
      })
    }
  })

  describe('#update32Unsafe()', () => {
    for (let i = 0; i < FUZZING_NUM; i++) {
      const packed = randomBigNumber()
      it(packed.toHexString(), async () => {
        for (let j = 0; j < 8; j++) {
          const value = randomBigNumber(MAX_UINT32)
          const ret = await packedLib.update32Unsafe(packed, j, value)
          expect(await packedLib.get32Unsafe(ret, j)).to.be.equal(
            value,
            `index ${j}`,
          )
        }
      })
    }
  })

  describe('#update32()', () => {
    it('should revert invalid index', async () => {
      await expect(
        packedLib.update32(randomBigNumber(), 8, randomBigNumber(MAX_UINT32)),
      ).to.be.revertedWith(
        encodeCustomError('PackedUint256Error(uint256)', [2], true),
      )
    })

    for (let i = 0; i < FUZZING_NUM; i++) {
      const packed = randomBigNumber()
      it(packed.toHexString(), async () => {
        for (let j = 0; j < 8; j++) {
          const value = randomBigNumber(MAX_UINT32)
          const ret = await packedLib.update32(packed, j, value)
          expect(await packedLib.get32Unsafe(ret, j)).to.be.equal(
            value,
            `index ${j}`,
          )
        }
      })
    }
  })

  describe('#update64Unsafe()', () => {
    for (let i = 0; i < FUZZING_NUM; i++) {
      const packed = randomBigNumber()
      it(packed.toHexString(), async () => {
        for (let j = 0; j < 4; j++) {
          const value = randomBigNumber(MAX_UINT64)
          const ret = await packedLib.update64Unsafe(packed, j, value)
          expect((await packedLib.get64Unsafe(ret, j)).toString()).to.be.equal(
            value.toString(),
            `index ${j}`,
          )
        }
      })
    }
  })

  describe('#update64()', () => {
    it('should revert invalid index', async () => {
      await expect(
        packedLib.update64(randomBigNumber(), 8, randomBigNumber(MAX_UINT64)),
      ).to.be.revertedWith(
        encodeCustomError('PackedUint256Error(uint256)', [3], true),
      )
    })

    for (let i = 0; i < FUZZING_NUM; i++) {
      const packed = randomBigNumber()
      it(packed.toHexString(), async () => {
        for (let j = 0; j < 4; j++) {
          const value = randomBigNumber(MAX_UINT64)
          const ret = await packedLib.update64(packed, j, value)
          expect((await packedLib.get64Unsafe(ret, j)).toString()).to.be.equal(
            value.toString(),
            `index ${j}`,
          )
        }
      })
    }
  })

  describe('#total32()', () => {
    for (let i = 0; i < FUZZING_NUM; i++) {
      const packed = randomBigNumber()
      it(packed.toHexString(), async () => {
        const promises: Promise<number>[] = []
        for (let j = 0; j < 8; j++) {
          promises.push(packedLib.get32Unsafe(packed, j))
        }
        const slices = await Promise.all(promises)
        const expectedSum = slices.reduce((a, b) => a + b, 0)
        expect(await packedLib.total32(packed)).to.be.equal(expectedSum)
      })
    }
  })

  describe('#total64()', () => {
    for (let i = 0; i < FUZZING_NUM; i++) {
      const packed = randomBigNumber()
      it(packed.toHexString(), async () => {
        const promises: Promise<BigNumber>[] = []
        for (let j = 0; j < 4; j++) {
          promises.push(packedLib.get64Unsafe(packed, j))
        }
        const slices = await Promise.all(promises)
        const expectedSum = slices.reduce((a, b) => a.add(b), BigNumber.from(0))
        expect((await packedLib.total64(packed)).toString()).to.be.equal(
          expectedSum.toString(),
        )
      })
    }
  })

  describe('#sum32()', () => {
    for (let i = 0; i < FUZZING_NUM; i++) {
      const packed = randomBigNumber()
      it(packed.toHexString(), async () => {
        const promises: Promise<number>[] = []
        for (let j = 0; j < 8; j++) {
          promises.push(packedLib.get32Unsafe(packed, j))
        }
        const slices = await Promise.all(promises)
        for (let from = 0; from < 8; from++) {
          for (let to = from; to < 8; to++) {
            const expectedSum = slices
              .filter((v, i) => from <= i && i < to)
              .reduce((a, b) => a + b, 0)
            expect(await packedLib.sum32(packed, from, to)).to.be.equal(
              expectedSum,
              `from ${from}, to ${to}`,
            )
          }
        }
      })
    }
  })

  describe('#sum64()', () => {
    for (let i = 0; i < FUZZING_NUM; i++) {
      const packed = randomBigNumber()
      it(packed.toHexString(), async () => {
        const promises: Promise<BigNumber>[] = []
        for (let j = 0; j < 4; j++) {
          promises.push(packedLib.get64Unsafe(packed, j))
        }
        const slices = await Promise.all(promises)
        for (let from = 0; from < 4; from++) {
          for (let to = from; to < 4; to++) {
            const expectedSum = slices
              .filter((v, i) => from <= i && i < to)
              .reduce((a, b) => a.add(b), BigNumber.from(0))
            expect(
              (await packedLib.sum64(packed, from, to)).toString(),
            ).to.be.equal(expectedSum.toString(), `from ${from}, to ${to}`)
          }
        }
      })
    }
  })
})
