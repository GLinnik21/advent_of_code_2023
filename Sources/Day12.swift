struct Day12: AdventDay {
  private enum Tube: Character, CustomStringConvertible {
    case operational = "."
    case damaged = "#"
    case unknown = "?"

    var description: String {
      return String(self.rawValue)
    }
  }

  private typealias Row = [Tube]
  private typealias DamagedGroups = [Int]
  private typealias Records = (row: Row, groups: DamagedGroups)

  private let records: [Records]

  init(data: String) {
    records = data.split(separator: "\n").compactMap({ line -> Records? in
      let parts = line.split(separator: " ")
      guard parts.count >= 2 else { return nil }

      return (
        parts[0].map { char -> Tube in
          switch char {
          case "#": return .damaged
          case ".": return .operational
          default: return .unknown
          }
        }, parts[1].split(separator: ",").compactMap { Int($0) }
      )
    })
  }

  private func combinationsOfOperational(for record: Records) -> [[Int]] {
    let operational = record.row.count - record.groups.reduce(0, +)
    let toDistribute = operational - (record.groups.count - 1)
    var result = [[Int]]()
    var combination = [Int](repeating: 0, count: record.groups.count + 1)

    func distribute(_ operational: Int, boxIndex: Int) {
      if boxIndex == combination.count - 1 {
        combination[boxIndex] = operational
        var adjustedCombination = combination
        for i in 1..<adjustedCombination.count - 1 {
          adjustedCombination[i] += 1
        }
        result.append(adjustedCombination)
        return
      }

      for i in 0...operational {
        combination[boxIndex] = i
        distribute(operational - i, boxIndex: boxIndex + 1)
      }
    }

    distribute(toDistribute, boxIndex: 0)
    return result
  }

  private func combinations(for record: Records) -> [Row] {
    combinationsOfOperational(for: record).map { operational in
      var combined = Row()
      var operationalIndex = 0
      var groupIndex = 0

      for _ in 0..<(operational.count + record.groups.count) {
        if operationalIndex < operational.count {
          combined.append(
            contentsOf: Array(repeating: .operational, count: operational[operationalIndex]))
          operationalIndex += 1
        }
        if groupIndex < record.groups.count {
          combined.append(contentsOf: Array(repeating: .damaged, count: record.groups[groupIndex]))
          groupIndex += 1
        }
      }
      return combined
    }
  }

  private func row(_ row: Row, fits unknowns: Row) -> Bool {
    zip(row, unknowns).allSatisfy { $1 == .unknown || $0 == $1 }
  }

  func part1() -> Any {
    records.map { record in
      combinations(for: record)
        .filter { row($0, fits: record.row) }.count
    }.reduce(0, +)
  }
}
