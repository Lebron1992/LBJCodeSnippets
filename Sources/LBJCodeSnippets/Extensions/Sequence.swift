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
