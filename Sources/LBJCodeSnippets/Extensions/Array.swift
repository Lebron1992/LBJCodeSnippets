import Foundation

public extension Array where Element: Hashable {
  func uniqued() -> [Element] {
    var seen = Set<Element>()
    return filter { seen.insert($0).inserted }
  }

  func containsDuplicate() -> Bool {
    return count != Set(self).count
  }

  func duplicatedElements() -> [Element] {
    var counts: [Element: Int] = [:]
    for element in self {
      counts[element, default: 0] += 1
    }
    return counts.filter { $1 > 1 }.map { $0.key }
  }
}
