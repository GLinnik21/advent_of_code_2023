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

  func part1() -> Any {
    var currentNode = "AAA"
    var steps = 0

    for direction in instructions.cycled() {
      steps += 1
      currentNode = (direction == "L") ? mapping[currentNode]!.0 : mapping[currentNode]!.1
      if currentNode == "ZZZ" { break }
    }

    return steps
  }
}
