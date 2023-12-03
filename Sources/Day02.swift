import Algorithms

struct Day02: AdventDay {
  var data: String

  private let gameLimits = (red: 12, green: 13, blue: 14)

  var entities: [[(red: Int, green: Int, blue: Int)]] {
    data.split(separator: "\n").map(parseGameLine)
  }

  private func parseGameLine(_ gameLine: Substring) -> [(red: Int, green: Int, blue: Int)] {
    gameLine.split(separator: ";").map { set in
      set.matches(of: #/(\d+)\s*(red|green|blue)/#).reduce(into: (red: 0, green: 0, blue: 0)) {
        counts, match in
        let (countStr, color) = (match.1, match.2)
        guard let count = Int(countStr) else { return }
        switch color {
        case "red": counts.red = count
        case "green": counts.green = count
        case "blue": counts.blue = count
        default: break
        }
      }
    }
  }

  func part1() -> Any {
    entities.enumerated().reduce(into: 0) { (accumulator, tuple) in
      let (index, game) = tuple
      if game.allSatisfy({ set in
        set.red <= gameLimits.red && set.green <= gameLimits.green && set.blue <= gameLimits.blue
      }) {
        accumulator += index + 1
      }
    }
  }

  func part2() -> Any {
    entities.reduce(into: 0) { sum, game in
      let maxValues = game.reduce((red: 0, green: 0, blue: 0)) { (maxSoFar, set) in
        (
          red: max(maxSoFar.red, set.red),
          green: max(maxSoFar.green, set.green),
          blue: max(maxSoFar.blue, set.blue)
        )
      }
      sum += maxValues.red * maxValues.green * maxValues.blue
    }
  }
}
