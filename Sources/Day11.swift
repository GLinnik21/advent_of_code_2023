import Algorithms

struct Day11: AdventDay {
  typealias Galaxy = (x: Int, y: Int)

  private let galaxies: [Galaxy]
  private let verticalSpaces: Set<Int>
  private let horizontalSpaces: Set<Int>
  private let expansion: Int

  init(data: String) {
    self.init(data: data, expansion: 1_000_000)
  }

  init(data: String, expansion: Int) {
    let lines = data.split(separator: "\n")

    var galaxiesLines = Set<Int>()
    var galaxiesColumns = Set<Int>()

    var tempGalaxies = [(Int, Int)]()

    for (j, line) in lines.enumerated() {
      for (i, element) in line.enumerated() {
        if element == "#" {
          tempGalaxies.append((i, j))
          galaxiesLines.insert(j)
          galaxiesColumns.insert(i)
        }
      }
    }

    galaxies = tempGalaxies
    verticalSpaces = Set(0..<lines.first!.count).subtracting(galaxiesColumns)
    horizontalSpaces = Set(0..<lines.count).subtracting(galaxiesLines)
    self.expansion = expansion
  }

  private func distance(of pairOfGalaxies: [(Galaxy)], expansionFactor: Int = 2) -> Int {
    guard let firstGalaxy = pairOfGalaxies.first, let lastGalaxy = pairOfGalaxies.last else {
      return 0
    }

    let (x1, y1) = (firstGalaxy.x, firstGalaxy.y)
    let (x2, y2) = (lastGalaxy.x, lastGalaxy.y)
    let xRange = min(x1, x2)...max(x1, x2)
    let yRange = min(y1, y2)...max(y1, y2)

    let verticalSpace = verticalSpaces.filter { xRange.contains($0) }.count * (expansionFactor - 1)
    let horizontalSpace =
      horizontalSpaces.filter { yRange.contains($0) }.count * (expansionFactor - 1)

    return abs(x1 - x2) + abs(y1 - y2) + verticalSpace + horizontalSpace
  }

  func part1() -> Any {
    galaxies.combinations(ofCount: 2).reduce(0) { sum, pairOfGalaxies in
      sum + distance(of: pairOfGalaxies)
    }
  }

  func part2() -> Any {
    galaxies.combinations(ofCount: 2).reduce(0) { sum, pairOfGalaxies in
      sum + distance(of: pairOfGalaxies, expansionFactor: expansion)
    }
  }
}
