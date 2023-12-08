import XCTest

@testable import AdventOfCode

final class Day08Tests: XCTestCase {
  func testPart1Direct() throws {
    let challenge = Day08(
      data: """
        RL

        AAA = (BBB, CCC)
        BBB = (DDD, EEE)
        CCC = (ZZZ, GGG)
        DDD = (DDD, DDD)
        EEE = (EEE, EEE)
        GGG = (GGG, GGG)
        ZZZ = (ZZZ, ZZZ)
        """)
    XCTAssertEqual(String(describing: challenge.part1()), "2")
  }
  func testPart1Repeat() throws {
    let challenge = Day08(
      data: """
        LLR

        AAA = (BBB, BBB)
        BBB = (AAA, ZZZ)
        ZZZ = (ZZZ, ZZZ)
        """)
    XCTAssertEqual(String(describing: challenge.part1()), "6")
  }
}
