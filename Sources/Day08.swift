import Algorithms

struct Day08: AdventDay {

  private let instructions: String
  private let mapping: [String: (String, String)]

  init(data: String) {
    let lines = data.split(separator: "\n").map(String.init)

    instructions = lines.first ?? ""

    mapping = lines.dropFirst().reduce(into: [String: (String, String)]()) { dict, line in
      if let match = line.firstMatch(of: #/(?<node>\w+) = \((?<left>\w+), (?<right>\w+)\)/#) {
        dict[String(match.node)] = (String(match.left), String(match.right))
      }
    }
  }

  fileprivate func steps(from node: String, to condition: (String) -> Bool) -> Int {
    var currentNode = node
    var steps = 0

    for direction in instructions.cycled() {
      steps += 1
      currentNode = (direction == "L") ? mapping[currentNode]!.0 : mapping[currentNode]!.1
      if condition(currentNode) { break }
    }

    return steps
  }

  func part1() -> Any {
    return steps(from: "AAA") { $0 == "ZZZ" }
  }

  private func gcd(_ a: Int, _ b: Int) -> Int {
    return b == 0 ? a : gcd(b, a % b)
  }

  private func lcm(_ a: Int, _ b: Int) -> Int {
    return (a * b) / gcd(a, b)
  }

  func part2() -> Any {
    let nodes = mapping.keys.filter { $0.last == "A" }
    return nodes.map { steps(from: $0, to: { $0.last == "Z" }) }.reduce(1, lcm)
  }
}
