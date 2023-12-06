struct Day06: AdventDay {
  typealias Race = (time: Int, distance: Int)

  let races: [Race]

  init(data: String) {
    let lines = data.split(separator: "\n")
    guard lines.count == 2 else {
      races = []
      return
    }

    let times = lines[0].split(separator: " ").compactMap { Int($0) }
    let distances = lines[1].split(separator: " ").compactMap { Int($0) }

    races = zip(times, distances).map { ($0, $1) }
  }

  func integerSolutions(distance: Double, time: Double) -> [Int] {
    let discriminant = time * time - 4 * distance
    guard discriminant >= 0 else { return [] }

    let root1 = (time - discriminant.squareRoot()) / 2
    let root2 = (time + discriminant.squareRoot()) / 2

    let lowerBound = Int(root1.rounded(.down)) + 1
    let upperBound = Int(root2.rounded(.up)) - 1

    return (lowerBound...upperBound).map { $0 }
  }

  func part1() -> Any {
    races
      .compactMap { integerSolutions(distance: Double($0.distance), time: Double($0.time)) }
      .compactMap { $0.count }
      .reduce(1, *)
  }
}
