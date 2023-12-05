import Algorithms

struct Day05: AdventDay {
  typealias Map = (source: ClosedRange<Int>, destination: ClosedRange<Int>)
  typealias Stage = [Map]

  let seeds: [Int]
  let gameStages: [Stage]

  init(data: String) {
    let sectors = data.split(separator: "\n\n")
    seeds = sectors.first!.split(separator: " ").compactMap { Int($0) }

    gameStages = sectors.dropFirst().compactMap { sector in
      sector.split(separator: "\n").dropFirst().compactMap { line in
        let map = line.split(separator: " ").compactMap { Int($0) }
        let sourceRange = map[1]...map[1] + map[2] - 1
        let destinationRange = map[0]...map[0] + map[2] - 1
        return (source: sourceRange, destination: destinationRange)
      }
    }
  }

  private func map(state: Int, for stage: Stage) -> Int {
    for map in stage {
      if map.source.contains(state) {
        let distance = state - map.source.upperBound
        return map.destination.upperBound + distance
      }
    }
    return state
  }

  private func map(seed: Int) -> Int {
    gameStages.reduce(seed) { mappedSeed, stage in
      return map(state: mappedSeed, for: stage)
    }
  }

  func part1() -> Any {
    seeds.compactMap { map(seed: $0) }.min()!
  }

  func part2() -> Any {
    return
      seeds
      .chunks(ofCount: 2)
      .compactMap { pair -> ClosedRange<Int>? in
        guard let start = pair.first, let distance = pair.last else { return nil }
        return start...(start + distance - 1)
      }
      .flatMap { range in
        range.map { seed in
          map(seed: seed)
        }
      }
      .min()!
  }
}
