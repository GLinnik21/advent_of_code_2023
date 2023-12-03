struct Matrix {
  private var data: [[Character]]
  var rowCount: Int { data.count }
  var columnCount: Int { data.first?.count ?? 0 }

  init(_ input: String) {
    data = input.split(separator: "\n").map { Array($0) }
  }

  func indexIsValid(row: Int, col: Int) -> Bool {
    return row >= 0 && row < data.count && col >= 0 && col < data[row].count
  }

  subscript(row: Int, column: Int) -> Character? {
    guard indexIsValid(row: row, col: column) else { return nil }
    return data[row][column]
  }

  func forEachElement(_ action: (Character, Int, Int) -> Void) {
    (0..<rowCount).forEach { row in
      (0..<columnCount).forEach { column in
        if let character = self[row, column] {
          action(character, row, column)
        }
      }
    }
  }
}

extension Matrix {
  func numberRangeAt(row: Int, column: Int) -> Range<Int>? {
    guard let character = self[row, column], character.isNumber else {
      return nil
    }

    let startCol = (0..<column).reversed().first(where: { self[row, $0]?.isNumber != true }) ?? 0
    let endCol =
      (column..<columnCount).first(where: { self[row, $0]?.isNumber != true }) ?? columnCount

    return startCol..<endCol
  }

  func numberForRange(row: Int, range: Range<Int>) -> Int? {
    return range.compactMap { self[row, $0]?.wholeNumberValue }.reduce(0, { $0 * 10 + $1 })
  }
}

struct Day03: AdventDay {
  private var matrix: Matrix

  init(data: String) {
    self.matrix = Matrix(data)
  }

  private func isValid(character: Character) -> Bool {
    character != "." && !character.isNumber
  }

  private func numbersAround(row: Int, column: Int) -> [Int] {
    let neighborOffsets = [
      (-1, -1), (-1, 0), (-1, 1),
      (0, -1), /*symbol*/ (0, 1),
      (1, -1), (1, 0), (1, 1),
    ]
    var deduplicationRanges = [(row: Int, range: Range<Int>)]()
    var numbers = [Int]()

    for (rowOffset, colOffset) in neighborOffsets {
      let neighborRow = row + rowOffset
      let neighborCol = column + colOffset

      if let range = matrix.numberRangeAt(row: neighborRow, column: neighborCol) {
        if let number = matrix.numberForRange(row: neighborRow, range: range),
          !deduplicationRanges.contains(where: { $0 == (neighborRow, range) })
        {
          deduplicationRanges.append((neighborRow, range))
          numbers.append(number)
        }
      }
    }
    return numbers
  }

  func part1() -> Any {
    var sum = 0
    matrix.forEachElement { character, row, column in
      if isValid(character: character) {
        sum += numbersAround(row: row, column: column).reduce(0, +)
      }
    }
    return sum
  }

  func part2() -> Any {
    var sum = 0
    matrix.forEachElement { character, row, column in
      if character == "*" {
        let numbers = numbersAround(row: row, column: column)
        if numbers.count > 1 {
          sum += numbers.reduce(1, *)
        }
      }
    }
    return sum
  }
}
