import Algorithms

struct Day11: AdventDay {
  private let galaxies: [(x: Int, y: Int)]
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

  func part1() -> Any {
    galaxies.combinations(ofCount: 2).reduce(0) { sum, pairOfGalaxies in
      let (x1, x2) = (pairOfGalaxies.first!.x, pairOfGalaxies.last!.x)
      let (y1, y2) = (pairOfGalaxies.first!.y, pairOfGalaxies.last!.y)
      let xRange = min(x1, x2)...max(x1, x2)
      let yRange = min(y1, y2)...max(y1, y2)
      let verticalSpace = verticalSpaces.filter { xRange.contains($0) }.count
      let horizontalSpace = horizontalSpaces.filter { yRange.contains($0) }.count

      return sum + abs(x1 - x2) + abs(y1 - y2) + verticalSpace + horizontalSpace
    }
  }

  func part2() -> Any {
    galaxies.combinations(ofCount: 2).reduce(0) { sum, pairOfGalaxies in
      let (x1, x2) = (pairOfGalaxies.first!.x, pairOfGalaxies.last!.x)
      let (y1, y2) = (pairOfGalaxies.first!.y, pairOfGalaxies.last!.y)
      let xRange = min(x1, x2)...max(x1, x2)
      let yRange = min(y1, y2)...max(y1, y2)

      let verticalSpace = verticalSpaces.filter { xRange.contains($0) }.count * (expansion - 1)
      let horizontalSpace = horizontalSpaces.filter { yRange.contains($0) }.count * (expansion - 1)

      return sum + abs(x1 - x2) + abs(y1 - y2) + verticalSpace + horizontalSpace
    }
  }
}
