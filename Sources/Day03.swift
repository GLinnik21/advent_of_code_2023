import Algorithms

struct Matrix {
    var data: [[Character]]
    
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
}

extension Matrix {
    func findNumbersAndOperate(
        _ operation: (_ number: Int, _ range: (row: Int, sci: Int, eci: Int)) -> Void
    ) {
        for (rowIndex, row) in data.enumerated() {
            let rowString = String(row)
            let matches = rowString.matches(of: #/\d+/#)
            
            for match in matches {
                let matchRange = match.range
                let numberString = rowString[matchRange]
                let startColumnIndex = rowString.distance(
                    from: rowString.startIndex, to: matchRange.lowerBound)
                let endColumnIndex = startColumnIndex + numberString.count - 1
                
                if let number = Int(numberString) {
                    operation(number, (rowIndex, startColumnIndex, endColumnIndex))
                }
            }
        }
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
    
    private func isValid(number range: (row: Int, sci: Int, eci: Int)) -> Bool {
        // Check row above and below
        for column in (range.sci - 1)...(range.eci + 1) {
            if isValid(atRow: range.row - 1, column: column) || isValid(atRow: range.row + 1, column: column) {
                return true
            }
        }
        // Check the row at start and end column index
        return isValid(atRow: range.row, column: range.sci - 1) || isValid(atRow: range.row, column: range.eci + 1)
    }
    
    private func isValid(atRow row: Int, column: Int) -> Bool {
        guard let character = matrix[row, column] else { return false }
        return isValid(character: character)
    }
    
    func part1() -> Any {
        var sum = 0
        matrix.findNumbersAndOperate { number, range in
            if isValid(number: range) { sum += number }
        }
        return sum
    }
}
