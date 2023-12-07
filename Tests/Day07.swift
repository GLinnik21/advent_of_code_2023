import XCTest

@testable import AdventOfCode

final class Day07Tests: XCTestCase {
  let testData = """
    32T3K 765
    T55J5 684
    KK677 28
    KTJJT 220
    QQQJA 483
    """

  func testPart1() throws {
    let challenge = Day07(data: testData)
    XCTAssertEqual(String(describing: challenge.part1()), "6440")
  }

  func testPart1AllTypes() throws {
    let challenge = Day07(
      data: """
        32T3K 765
        T55J5 684
        KK677 28
        KTJJT 220
        QQQJA 483
        AAAAA 100
        AA8AA 200
        23332 300
        """)
    XCTAssertEqual(String(describing: challenge.part1()), "10440")
  }

  func testPart1Equal5() throws {
    let challenge = Day07(
      data: """
        AAAAA 100
        22222 1
        """)
    XCTAssertEqual(String(describing: challenge.part1()), "201")
  }

  func testPart1Equal4() throws {
    let challenge = Day07(
      data: """
        AAAA7 100
        AA8AA 1
        """)
    XCTAssertEqual(String(describing: challenge.part1()), "201")
  }

  func testPart2() throws {
    let challenge = Day07(
      data: """
        32T3K 765
        T55J5 684
        KK677 28
        KTJJT 220
        QQQJA 483
        """)
    XCTAssertEqual(String(describing: challenge.part2()), "5905")
  }
}
