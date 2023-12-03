import Foundation

struct Day01: AdventDay {
  private let mapping = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
  var data: String

  var entities: [String] {
    data.components(separatedBy: "\n")
  }

  func part1() -> Any {
    var sum = 0
    for line in entities {
      if let first = line.first(where: { $0.isNumber }),
        let last = line.last(where: { $0.isNumber })
      {
        sum += Int("\(first)\(last)")!
      }
    }
    return sum
  }

  func part2() -> Any {
    var sum = 0
    for line in entities {
      let numberRanges = mapping.flatMap { line.ranges(of: $0) }
      let lowest = numberRanges.min(by: { $0.lowerBound < $1.lowerBound })
      let highest = numberRanges.max(by: { $0.lowerBound < $1.lowerBound })
      let firstDigitIndex = line.firstIndex(where: { $0.isNumber })
      let lastDigitIndex = line.lastIndex(where: { $0.isNumber })

      let digit1: Int
      if let firstDigit = firstDigitIndex, lowest == nil || lowest!.lowerBound > firstDigit {
        digit1 = line[firstDigit].wholeNumberValue!
      } else if let lowestRange = lowest {
        digit1 = mapping.firstIndex(of: String(line[lowestRange]))! + 1
      } else {
        digit1 = 0  // Or some default value
      }

      let digit2: Int
      if let lastDigit = lastDigitIndex, highest == nil || highest!.lowerBound < lastDigit {
        digit2 = line[lastDigit].wholeNumberValue!
      } else if let highestRange = highest {
        digit2 = mapping.firstIndex(of: String(line[highestRange]))! + 1
      } else {
        digit2 = 0  // Or some default value
      }

      let lineSum = digit1 * 10 + digit2
      //            print("Line: \(line), Digit1: \(digit1), Digit2: \(digit2), Line Sum: \(lineSum)")
      sum += lineSum
    }
    return sum
  }
}
