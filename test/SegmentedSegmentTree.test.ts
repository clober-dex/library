import { ethers, network } from 'hardhat'
import { BigNumber, Contract } from 'ethers'
import { expect } from 'chai'
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers'

import { SegmentedSegmentTreeWrapper } from '../typechain'
import { getSnapshot, setSnapshot } from '../utils/misc'
import { SegmentTree } from '../utils/segment-tree'

import { encodeCustomError } from './utils'

const data = require('../utils/segment-tree.dummy.json')

const MAX_ORDERS = 32768
const BATCH_SIZE = 1250

describe('SegmentedSegmentTree', () => {
  //@ts-ignore
  const Web3 = require('web3')
  const web3 = new Web3(network.provider)
  let TreeTest: SegmentedSegmentTreeWrapper
  let admin: SignerWithAddress
  let TreeWithWeb3: Contract
  const tree = new SegmentTree()

  before(async () => {
    TreeTest = (await (
      await ethers.getContractFactory('SegmentedSegmentTreeWrapper')
    ).deploy()) as SegmentedSegmentTreeWrapper
    ;[admin] = await ethers.getSigners()

    for (const [index, value] of data['values'].entries()) {
      tree.updateTreeNode(index, BigNumber.from(value))
    }

    const updateParams = data['values'].map((value: number, index: number) => ({
      index,
      value,
    }))

    for (let i = 0; i < MAX_ORDERS; i += BATCH_SIZE) {
      await TreeTest.updateBatch(updateParams.slice(i, i + BATCH_SIZE))
      console.log('updateBatch', i)
    }

    TreeWithWeb3 = new web3.eth.Contract(
      JSON.parse(<string>TreeTest.interface.format(ethers.utils.FormatTypes.json)),
      TreeTest.address,
    )
    await setSnapshot('SegmentedSegmentTree')
  })

  beforeEach(async () => {
    await getSnapshot('SegmentedSegmentTree')
    await setSnapshot('SegmentedSegmentTree')
  })

  async function test(l: number, r: number) {
    const calldata = TreeWithWeb3.methods.query(l, r).encodeABI()
    const receipt = await admin.sendTransaction({
      to: TreeTest.address,
      data: calldata,
    })
    await receipt.wait()
    expect(await TreeTest.query(l, r).then((v) => v.toString())).to.be.equal(tree.query(l, r).toString())
  }

  async function testAllQueries() {
    expect(await TreeTest.get(1115)).to.be.equal(tree.query(1115, 1116))
    expect(await TreeTest.get(1116)).to.be.equal(tree.query(1116, 1117))

    await expect(TreeTest.get(MAX_ORDERS + 1)).to.be.revertedWith(
      encodeCustomError('SegmentedSegmentTreeError(uint256)', [0], true),
    )
    await expect(TreeTest.get(MAX_ORDERS + 10)).to.be.revertedWith(
      encodeCustomError('SegmentedSegmentTreeError(uint256)', [0], true),
    )

    await test(444, 444)
    await test(0, MAX_ORDERS)

    // l = layer
    for (let l = 0; l < 4; l++) {
      const offset = (3 - l) * 4000
      const groupSize = 4 * 16 ** l

      // n = number of groups
      for (let n = 1; n < (l === 3 ? 3 : 5); n++) {
        const size = groupSize * n
        for (let i = 0; i < (l === 3 ? (n === 1 ? 2 : 1) : 4); i++) {
          await test(offset + i * groupSize, offset + size + i * groupSize)
          await test(offset + i * groupSize + 1, offset + size + i * groupSize)
          await test(offset + i * groupSize, offset + size + i * groupSize - 1)
          await test(offset + i * groupSize + 1, offset + size + i * groupSize - 1)
        }
      }
    }
  }

  it('total', async () => {
    const total = await TreeTest.total()
    expect(total.toString()).to.be.equal(tree.query(0, MAX_ORDERS).toString())
  })

  it('query', async () => {
    await testAllQueries()
  })

  it('query after update', async () => {
    const updateParams = [...new Array(MAX_ORDERS)].map((_, index: number) => ({
      index,
      value: index + 1,
    }))

    for (let i = 0; i < MAX_ORDERS; i++) {
      tree.updateTreeNode(i, BigNumber.from(i + 1))
    }
    for (let i = 0; i < MAX_ORDERS; i += BATCH_SIZE) {
      await TreeTest.updateBatch(updateParams.slice(i, i + BATCH_SIZE))
    }

    await testAllQueries()
  })

  it('index errors on query', async () => {
    await expect(TreeTest.query(10, 5)).to.be.revertedWith(
      encodeCustomError('SegmentedSegmentTreeError(uint256)', [0], true),
    )
    await expect(TreeTest.query(0, 2 ** 16)).to.be.revertedWith(
      encodeCustomError('SegmentedSegmentTreeError(uint256)', [0], true),
    )
  })

  it('check out of index on update', async () => {
    await expect(TreeTest.update(BigNumber.from(2).pow(16), 0)).to.be.revertedWith(
      encodeCustomError('SegmentedSegmentTreeError(uint256)', [0], false),
    )
  })

  it('check overflow on update', async () => {
    const value = BigNumber.from(2).pow(63)
    await TreeTest.update(0, value)
    await expect(TreeTest.update(1, value)).to.be.revertedWith(
      encodeCustomError('SegmentedSegmentTreeError(uint256)', [1], false),
    )
  })
})
