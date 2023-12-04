import Darwin

struct Day04: AdventDay {
  var data: String

  var entities: [(winning: Set<Int>, all: Set<Int>)] {
    data.split(separator: "\n").compactMap { line in
      guard let last = line.split(separator: ":").last?.split(separator: "|") else { return nil }
      guard let winningPart = last.first, let numbersPart = last.last else { return nil }

      let winning = winningPart.split(separator: " ").compactMap { Int($0) }
      let numbers = numbersPart.split(separator: " ").compactMap { Int($0) }

      return (Set(winning), Set(numbers))
    }
  }

  func part1() -> Any {
    var sum = 0
    entities.forEach { game in
      sum += Int(pow(2.0, Double(game.winning.intersection(game.all).count - 1)))
    }
    return sum
  }
}
