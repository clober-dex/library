import { BigNumber } from 'ethers'

export class SegmentTree {
  private n = 32768 // array size
  private readonly tree: BigNumber[]

  constructor() {
    this.tree = new Array(2 * this.n)
    this.tree.fill(BigNumber.from(0))
  }

  updateTreeNode(p: number, value: BigNumber) {
    this.tree[p + this.n] = value
    p = p + this.n
    for (let i = p; i > 1; i >>= 1) {
      this.tree[i >> 1] = this.tree[i].add(this.tree[i ^ 1])
    }
  }

  query(l: number, r: number) {
    let res = BigNumber.from(0)

    // loop to find the sum in the range
    for (l += this.n, r += this.n; l < r; l >>= 1, r >>= 1) {
      if ((l & 1) > 0) {
        res = res.add(this.tree[l++])
      }

      if ((r & 1) > 0) {
        res = res.add(this.tree[--r])
      }
    }

    return res
  }
}
