struct Day06: AdventDay {
  typealias Race = (time: Int, distance: Int)

  var data: String

  var part1Races: [Race] {
    let lines = data.split(separator: "\n")
    guard lines.count == 2 else { return [] }

    let times = lines[0].split(separator: " ").compactMap { Int($0) }
    let distances = lines[1].split(separator: " ").compactMap { Int($0) }

    return zip(times, distances).map { ($0, $1) }
  }

  var part2Race: Race {
    let lines = data.split(separator: "\n")
    guard lines.count == 2,
      let times = Int(lines[0].filter { $0.isWholeNumber }),
      let distances = Int(lines[1].filter { $0.isWholeNumber })
    else {
      return (0, 0)
    }
    return (times, distances)
  }

  func integerSolutions(distance: Double, time: Double) -> Int {
    let discriminant = time * time - 4 * distance
    guard discriminant >= 0 else { return 0 }

    let root1 = (time - discriminant.squareRoot()) / 2
    let root2 = (time + discriminant.squareRoot()) / 2

    let lowerBound = Int(root1.rounded(.down)) + 1
    let upperBound = Int(root2.rounded(.up)) - 1

    return (lowerBound...upperBound).count
  }

  func part1() -> Any {
    part1Races
      .compactMap { integerSolutions(distance: Double($0.distance), time: Double($0.time)) }
      .reduce(1, *)
  }

  func part2() -> Any {
    let race = part2Race
    return integerSolutions(distance: Double(race.distance), time: Double(race.time))
  }
}
