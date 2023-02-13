import hre from 'hardhat'
import Heap from 'heap-js'
import { expect } from 'chai'

import { OctopusHeapWrapper } from '../typechain'
import { generateRandoms, getSnapshot, setSnapshot } from '../utils/misc'

import { encodeCustomError } from './utils'

const { ethers } = hre

describe('OctopusHeapWrapper Test', () => {
  let minHeapTest: OctopusHeapWrapper

  before(async () => {
    minHeapTest = (await (
      await ethers.getContractFactory('OctopusHeapWrapper')
    ).deploy()) as OctopusHeapWrapper
  })

  describe('after init', async () => {
    before(async () => {
      await minHeapTest.init()
      await setSnapshot('OctopusHeap')
    })

    beforeEach(async () => {
      await getSnapshot('OctopusHeap')
      await setSnapshot('OctopusHeap')
    })

    async function testPop() {
      let [word, heap] = await minHeapTest.getRootWordAndHeap()
      ;[word, heap] = await minHeapTest.popInMemory(word, heap)

      const min = await minHeapTest.root()
      expect(await minHeapTest.has(min)).to.be.true
      await minHeapTest.pop()

      const [expectedWord, expectedHeap] =
        await minHeapTest.getRootWordAndHeap()
      expect(word).to.be.eq(expectedWord)
      for (let i = 0; i < 9; i++) {
        expect(heap[i]).to.be.eq(expectedHeap[i])
      }

      expect(await minHeapTest.has(min)).to.be.false
      if (!(await minHeapTest.isEmpty())) {
        expect(await minHeapTest.root()).to.be.gt(min)
      }
    }

    it('revert when already init', async () => {
      await expect(minHeapTest.init()).to.be.revertedWith(
        encodeCustomError('OctopusHeapError(uint256)', [0]),
      )
    })

    it('revert when none', async () => {
      await expect(minHeapTest.root()).to.be.revertedWith(
        encodeCustomError('OctopusHeapError(uint256)', [1], true),
      )
    })

    it('push and pop', async () => {
      await minHeapTest.push(23)
      expect(await minHeapTest.root()).to.be.eq(23)
      expect(await minHeapTest.has(23)).to.be.true

      await minHeapTest.pop()
      expect(await minHeapTest.isEmpty()).to.be.eq(true)
      expect(await minHeapTest.has(23)).to.be.false
    })

    it('push and pop min uint16', async () => {
      await minHeapTest.push(1)
      expect(await minHeapTest.root()).to.be.eq(1)
      expect(await minHeapTest.has(1)).to.be.true

      await minHeapTest.pop()
      expect(await minHeapTest.isEmpty()).to.be.eq(true)
      expect(await minHeapTest.has(1)).to.be.false
    })

    it('push and pop two(same node)', async () => {
      await minHeapTest.push(28)
      expect(await minHeapTest.root()).to.be.eq(28)

      await minHeapTest.push(23)
      expect(await minHeapTest.root()).to.be.eq(23)

      await minHeapTest.pop()
      expect(await minHeapTest.root()).to.be.eq(28)
      expect(await minHeapTest.has(28)).to.be.true
      expect(await minHeapTest.has(23)).to.be.false

      await minHeapTest.pop()
      expect(await minHeapTest.isEmpty()).to.be.eq(true)
    })

    it('push and pop two(not same node) - 1', async () => {
      await minHeapTest.push(328)
      expect(await minHeapTest.root()).to.be.eq(328)

      await minHeapTest.push(23)
      expect(await minHeapTest.root()).to.be.eq(23)

      await minHeapTest.pop()
      expect(await minHeapTest.root()).to.be.eq(328)
      expect(await minHeapTest.has(328)).to.be.true
      expect(await minHeapTest.has(23)).to.be.false

      await minHeapTest.pop()
      expect(await minHeapTest.isEmpty()).to.be.eq(true)
    })

    it('push and pop two(not same node) - 2', async () => {
      await minHeapTest.push(328)
      expect(await minHeapTest.root()).to.be.eq(328)

      await minHeapTest.push(1)
      expect(await minHeapTest.root()).to.be.eq(1)

      await minHeapTest.pop()
      expect(await minHeapTest.root()).to.be.eq(328)
      expect(await minHeapTest.has(328)).to.be.true
      expect(await minHeapTest.has(1)).to.be.false

      await minHeapTest.pop()
      expect(await minHeapTest.isEmpty()).to.be.eq(true)
    })

    it('push two which is duplicated will be reverted', async () => {
      await minHeapTest.push(23)
      expect(await minHeapTest.root()).to.be.eq(23)

      await expect(minHeapTest.push(23)).to.be.revertedWith(
        encodeCustomError('OctopusHeapError(uint256)', [2]),
      )
    })

    it('pop twice which is duplicated will be reverted', async () => {
      await minHeapTest.push(23)
      expect(await minHeapTest.root()).to.be.eq(23)

      await minHeapTest.pop()
      await expect(minHeapTest.pop()).to.be.reverted
    })

    it('push in all independent nodes', async () => {
      const minHeap = new Heap()
      for (let i = 0; i < 256; i++) {
        const number = i * 256
        minHeap.push(number)
        await minHeapTest.push(number)
        expect(await minHeapTest.root()).to.be.eq(minHeap.peek())
      }
      while (!(await minHeapTest.isEmpty())) {
        expect(await minHeapTest.root()).to.be.eq(minHeap.peek())
        minHeap.pop()
        await testPop()
      }
    })

    it('fuzzing test', async () => {
      const minHeap = new Heap()
      const randomNumbers = generateRandoms(1, 2 ** 16 - 1, 1000)
      for (let run = 0; run < 10; run++) {
        for (let j = 0; j < 100; j++) {
          const num = randomNumbers.pop() as number
          minHeap.push(num)
          await minHeapTest.push(num)
          expect(await minHeapTest.root()).to.be.eq(minHeap.peek())
        }
        for (let i = 0; i < 50; i++) {
          expect(await minHeapTest.root()).to.be.eq(minHeap.peek())
          minHeap.pop()
          await testPop()
        }
      }
      while (!(await minHeapTest.isEmpty())) {
        expect(await minHeapTest.root()).to.be.eq(minHeap.peek())
        minHeap.pop()
        await testPop()
      }
    })
  })
})
