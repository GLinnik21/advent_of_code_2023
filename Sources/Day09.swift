struct Day09: AdventDay {

  let histories: [[Int]]

  init(data: String) {
    histories = data.split(separator: "\n").compactMap {
      $0.split(separator: " ").compactMap { Int($0) }
    }
  }

  private func interpolateFuture(_ history: [Int]) -> Int {
    if history.allSatisfy({ $0 == 0 }) { return 0 }
    return history.last! + interpolateFuture(history.differences())
  }

  private func interpolatePast(_ history: [Int]) -> Int {
    if history.allSatisfy({ $0 == 0 }) { return 0 }
    return history.first! - interpolatePast(history.differences())
  }

  func part1() -> Any {
    histories.map { interpolateFuture($0) }.reduce(0, +)
  }

  func part2() -> Any {
    histories.map { interpolatePast($0) }.reduce(0, +)
  }
}

extension Array where Element: Numeric {
  func differences() -> [Element] {
    zip(self, self.dropFirst()).map { $1 - $0 }
  }
}
