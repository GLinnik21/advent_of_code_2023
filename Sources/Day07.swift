struct Day07: AdventDay {
  typealias Deck = String
  typealias Hand = (hand: Deck, bid: Int)
  typealias Mapping = [Character: Int]

  private let game: [Hand]

  init(data: String) {
    game = data.split(separator: "\n").compactMap { line -> Hand? in
      let components = line.split(separator: " ")
      guard components.count == 2,
        let handStr = components.first,
        let bidStr = components.last,
        let bid = Int(bidStr)
      else {
        return nil
      }
      return (hand: String(handStr), bid: bid)
    }
  }

  private static func parseHand(_ hand: Deck, mapping: Mapping) -> [Int] {
    hand.compactMap { card in
      Int(String(card)) ?? mapping[card]
    }
  }

  private func compare(hand left: Deck, cardByCardWith right: Deck, mapping: Mapping) -> Bool {
    let leftMapped = Day07.parseHand(left, mapping: mapping)
    let rightMapped = Day07.parseHand(right, mapping: mapping)

    for pair in zip(leftMapped, rightMapped) {
      if pair.0 != pair.1 { return pair.0 < pair.1 }
    }
    return false
  }

  private func updateSetForJokers(_ set: inout [Character: Int], withJokers jokersCount: Int) {
    if jokersCount != 5,
      let maxElement = set.filter({ $0.key != "J" }).max(by: { $0.value < $1.value })?.key
    {
      set[maxElement] = (set[maxElement] ?? 0) + jokersCount
      set.removeValue(forKey: "J")
    }
  }

  private func hand(_ left: Deck, smallerThan right: Deck, mapping: Mapping) -> Bool {
    var leftSet = left.countedSet
    var rightSet = right.countedSet

    if mapping["J"] == 1 {  // Treat as Joker
      updateSetForJokers(&leftSet, withJokers: leftSet["J"] ?? 0)
      updateSetForJokers(&rightSet, withJokers: rightSet["J"] ?? 0)
    }

    if leftSet.count == rightSet.count {
      let leftMax = leftSet.values.max() ?? 0
      let rightMax = rightSet.values.max() ?? 0
      return leftMax != rightMax
        ? leftMax < rightMax : compare(hand: left, cardByCardWith: right, mapping: mapping)
    }

    return leftSet.count > rightSet.count  // the more objects – the weaker the hand
  }

  func part1() -> Any {
    game.sorted {
      hand(
        $0.hand, smallerThan: $1.hand,
        mapping: [
          "A": 14,
          "K": 13,
          "Q": 12,
          "J": 11,
          "T": 10,
        ])
    }
    .enumerated()
    .reduce(into: 0) { result, element in
      result += (element.offset + 1) * element.element.bid
    }
  }

  func part2() -> Any {
    game.sorted {
      hand(
        $0.hand, smallerThan: $1.hand,
        mapping: [
          "A": 14,
          "K": 13,
          "Q": 12,
          "J": 1,
          "T": 10,
        ])
    }
    .enumerated()
    .reduce(into: 0) { result, element in
      result += (element.offset + 1) * element.element.bid
    }
  }
}

extension String {
  var countedSet: [Character: Int] {
    self.reduce(into: [:]) { counts, element in
      counts[element, default: 0] += 1
    }
  }
}
