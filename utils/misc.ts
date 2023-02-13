import {
  BigNumber,
  BigNumberish,
  Contract,
  ContractTransaction,
  utils,
} from 'ethers'
import { HardhatRuntimeEnvironment } from 'hardhat/types'

import { NETWORK } from './constant'

export const snapshots = new Map<string, string>()

let HRE: HardhatRuntimeEnvironment | undefined
export const getHRE = (): HardhatRuntimeEnvironment => {
  if (!HRE) {
    HRE = require('hardhat')
  }
  return HRE as HardhatRuntimeEnvironment
}

export const liveLog = (str: string): void => {
  if (getHRE().network.name !== NETWORK.HARDHAT) {
    console.log(str)
  }
}

export const bn2StrWithPrecision = (
  bn: BigNumber,
  precision: number,
): string => {
  const prec = BigNumber.from(10).pow(precision)
  const q = bn.div(prec)
  const r = bn.mod(prec)
  return q.toString() + '.' + r.toString().padStart(precision, '0')
}

export const convertToDateString = (utc: BigNumber): string => {
  return new Date(utc.toNumber() * 1000).toLocaleDateString('ko-KR', {
    year: '2-digit',
    month: '2-digit',
    day: '2-digit',
    hour: '2-digit',
    minute: '2-digit',
    second: '2-digit',
  })
}

export const sleep = (ms: number): Promise<void> => {
  return new Promise((resolve) => setTimeout(resolve, ms))
}

export const waitForTx = async (tx: Promise<ContractTransaction>) => {
  return (await tx).wait()
}

export function randomBigNumber(): BigNumber
export function randomBigNumber(max: BigNumberish): BigNumber
export function randomBigNumber(min: BigNumberish, max: BigNumberish): BigNumber
export function randomBigNumber(
  min?: BigNumberish,
  max?: BigNumberish,
): BigNumber {
  if (!max) {
    max = min
    min = undefined
  }
  if (max === 0) {
    return BigNumber.from(0)
  }
  if (!min) {
    min = BigNumber.from(0)
  }
  if (!max) {
    max = BigNumber.from(2).pow(256).sub(1)
  }
  return BigNumber.from(utils.randomBytes(32))
    .mod(BigNumber.from(max).sub(min).add(1))
    .add(min)
}

export const generateRandoms = (
  min: number,
  max: number,
  numOfRandoms: number,
): number[] => {
  const randoms = Array.from({ length: max - min + 1 }, (_, i) => i + min)
    .sort(() => 0.5 - Math.random())
    .slice(0, numOfRandoms)
  return randoms
}

export class UsefulMap<K, V> extends Map<K, V> {
  constructor(...initValues: [K, V][]) {
    super()
    for (const initValue of initValues) {
      this.set(initValue[0], initValue[1])
    }
  }

  mustGet(key: K): V {
    const value = this.get(key)
    if (!value) {
      throw new Error(`UsefulMap mustGet failed`)
    }
    return value
  }

  async forEachAsync(
    callbackfn: (value: V, key: K, map: UsefulMap<K, V>) => Promise<void>,
  ): Promise<void> {
    for (const [key, value] of this.entries()) {
      await callbackfn(value, key, this)
    }
  }
}

export const evmSnapshot = async (): Promise<string> => {
  const hre = getHRE()
  return hre.ethers.provider.send('evm_snapshot', [])
}

export const evmRevert = async (id: string): Promise<void> => {
  const hre = getHRE()
  // id is consumed when user call `evm_revert`
  await hre.ethers.provider.send('evm_revert', [id])
}

export const setSnapshot = async (name: string): Promise<void> => {
  snapshots.set(name, await evmSnapshot())
}

export const getSnapshot = async (name: string): Promise<void> => {
  const id = snapshots.get(name)
  await evmRevert(id || '1')
}
