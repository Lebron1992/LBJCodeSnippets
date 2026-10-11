import Foundation

public extension Sequence where Iterator.Element == NSAttributedString {
  func joined(with separator: NSAttributedString) -> NSAttributedString {
    reduce(NSMutableAttributedString()) {
      (r, e) in
      if r.length > 0 {
        r.append(separator)
      }
      r.append(e)
      return r
    }
  }

  func joined(with separator: String = "") -> NSAttributedString {
    joined(with: NSAttributedString(string: separator))
  }
}

public extension Sequence {
  func removingDuplicates<T: Hashable>(withSame keyPath: KeyPath<Element, T>) -> [Element] {
    var seen = Set<T>()
    return filter { element in
      guard seen.insert(element[keyPath: keyPath]).inserted else { return false }
      return true
    }
  }
}
