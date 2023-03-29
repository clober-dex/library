# Solidity Library by Clober test

----
[![Docs](https://img.shields.io/badge/docs-%F0%9F%93%84-blue)](https://docs.clober.io/contracts/overview)
[![codecov](https://codecov.io/gh/clober-dex/library/branch/main/graph/badge.svg?token=NP4EA3VJ0W)](https://codecov.io/gh/clober-dex/library)
[![CI status](https://github.com/clober-dex/library/actions/workflows/ci.yaml/badge.svg)](https://github.com/clober-dex/library/actions/workflows/ci.yaml)

Implementation of [Clober](https://clober.io/) library contracts: SegmentedSegmentTree, OctopusHeap, and more.
- [SegmentedSegmentTree](https://docs.clober.io/concepts/technical/tree)
- [OctopusHeap](https://docs.clober.io/concepts/technical/heap)

## Features
- **[SegmentedSegmentTree](https://docs.clober.io/contracts/library/CloberSegmentedSegmentTree)**: A gas-efficient [segment tree](https://en.wikipedia.org/wiki/Segment_tree) with a fixed size to support 32768 leaf nodes.
- **[OctopusHeap](https://docs.clober.io/contracts/library/CloberOctopusHeap)**: A heap data structure that can store up to 256 `uint16` values. Optimized for popping values in close proximity to each other.
- **[PackedUint256](https://docs.clober.io/contracts/library/CloberPackedUint256)**: Treats a `uint256` as a group of `uint8`, `uint16`, or `uint32` and adds, subtracts, or updates the elements of the group by indexing them.
- **[Create1](https://docs.clober.io/contracts/library/CloberCreate1)**: Utility functions regarding the vanilla `CREATE` operation.
- **[DirtyUint64](https://docs.clober.io/contracts/library/CloberDirtyUint64)**: Adds, subtracts, and converts clean (original) and dirty (a non-zero representation of the original) `uint64` values.
## Installation

---------

```shell
npm install @clober/library
```

## Testing

---------

We use [hardhat](https://hardhat.org/) for code coverage and [foundry](https://getfoundry.sh/) for fuzzing tests.

### Check Code Coverage
```shell
npm run hardhat:coverage
open coverage/index.html
```

### Run Fuzzing Tests
```shell
npm run forge:test
```

## Visualization
Visual aid for OctopusHeap.
```shell
cd utils/visualization
pip install -r requirements.txt 
python octopus_heap.py
```

## Audits
Audited by [Spearbit](https://github.com/spearbit) from January to February 2023. All security risks are fixed. Full report is available [here](audits/SpearbitDAO2023Feb.pdf).

## Licensing

---------

The primary license for Clober Library is the Time-delayed Open Source Software Licence, see [License file](LICENSE.pdf).
