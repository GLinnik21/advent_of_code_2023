struct Day07: AdventDay {
  typealias Deck = [Int]
  typealias Hand = (hand: Deck, bid: Int)

  private let game: [Hand]

  private static let mapping: [Character: Int] = [
    "A": 14,
    "K": 13,
    "Q": 12,
    "J": 11,
    "T": 10,
  ]

  init(data: String) {
    game = data.split(separator: "\n").compactMap { line in
      let components = line.split(separator: " ")
      guard components.count == 2,
        let hand = Day07.parseHand(components[0]),
        let bid = Int(components[1])
      else {
        return nil
      }
      return (hand, bid)
    }
  }

  private static func parseHand(_ substring: Substring) -> Deck? {
    substring.compactMap { card in
      if let number = Int(String(card)) {
        return number
      } else {
        return mapping[card]
      }
    }
  }

  private func compare(hand left: Deck, cardByCardWith right: Deck) -> Bool {
    for pair in zip(left, right) {
      if pair.0 != pair.1 { return pair.0 < pair.1 }
    }
    return false
  }

  private func hand(_ left: Deck, smallerThan right: Deck) -> Bool {
    let leftSet = left.countedSet
    let rightSet = right.countedSet

    if leftSet.count == rightSet.count {
      let leftMax = leftSet.values.max() ?? 0
      let rightMax = rightSet.values.max() ?? 0
      if leftMax != rightMax {
        return leftMax < rightMax  // Three of a kind (3) wins over two pairs (2)
      }

      return compare(hand: left, cardByCardWith: right)  // power of hands are the same, compare card by card
    }

    return leftSet.count > rightSet.count  // the more objects – the weaker the hand
  }

  func part1() -> Any {
    game.sorted { hand($0.hand, smallerThan: $1.hand) }
      .enumerated()
      .reduce(into: 0) { result, element in
        result += (element.offset + 1) * element.element.bid
      }
  }
}

extension Array where Element: Hashable {
  var countedSet: [Element: Int] {
    self.reduce(into: [:]) { counts, element in
      counts[element, default: 0] += 1
    }
  }
}
