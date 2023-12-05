struct Day04: AdventDay {
  var entities: [(winning: Set<Int>, all: Set<Int>)]

  init(data: String) {
    entities = data.split(separator: "\n").compactMap { line in
      guard let last = line.split(separator: ":").last?.split(separator: "|") else { return nil }
      guard let winningPart = last.first, let numbersPart = last.last else { return nil }

      let winning = winningPart.split(separator: " ").compactMap { Int($0) }
      let numbers = numbersPart.split(separator: " ").compactMap { Int($0) }

      return (Set(winning), Set(numbers))
    }
  }

  func part1() -> Any {
    entities.reduce(into: 0) { sum, game in
      sum += 1 << (game.winning.intersection(game.all).count - 1)
    }
  }

  func part2() -> Any {
    var copies = [Int](repeating: 1, count: entities.count)
    for (index, game) in entities.enumerated() {
      let won = game.winning.intersection(game.all).count
      let range = (index + 1)..<min(index + 1 + won, entities.count)

      range.forEach { copies[$0] += copies[index] }
    }
    return copies.reduce(0, +)
  }
}
