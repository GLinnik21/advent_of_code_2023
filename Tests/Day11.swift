import XCTest

@testable import AdventOfCode

final class Day11Tests: XCTestCase {
  let testData = """
    ...#......
    .......#..
    #.........
    ..........
    ......#...
    .#........
    .........#
    ..........
    .......#..
    #...#.....
    """

  func testPart1() throws {
    let challenge = Day11(data: testData)
    XCTAssertEqual(String(describing: challenge.part1()), "374")
  }

  func testPart2_10() throws {
    let challenge = Day11(data: testData, expansion: 10)
    XCTAssertEqual(String(describing: challenge.part2()), "1030")
  }

  func testPart2_100() throws {
    let challenge = Day11(data: testData, expansion: 100)
    XCTAssertEqual(String(describing: challenge.part2()), "8410")
  }
}
