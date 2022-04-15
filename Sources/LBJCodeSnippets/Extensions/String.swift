import Foundation
import UIKit

extension String {
  public var isEmail: Bool {
    let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let pred = NSPredicate(format: "SELF MATCHES %@", regEx)
    return pred.evaluate(with: self)
  }

  public var isPhone: Bool {
    let regEx = "^((\\+)|(00))[0-9]{6,14}|[0-9]{6,14}$"
    let pred = NSPredicate(format: "SELF MATCHES %@", regEx)
    return pred.evaluate(with: self)
  }

  public var trimmed: String {
    trimmingCharacters(in: .whitespacesAndNewlines)
  }

  public func sizeWithFont(_ font: UIFont) -> CGSize {
    let fontAttributes = [NSAttributedString.Key.font: font]
    return (self as NSString).size(withAttributes: fontAttributes)
  }

  public subscript(_ range: CountableRange<Int>) -> String {
    let start = index(startIndex, offsetBy: max(0, range.lowerBound))
    let end = index(
      start,
      offsetBy: min(count - range.lowerBound, range.upperBound - range.lowerBound)
    )
    return String(self[start..<end])
  }

  public subscript(_ range: CountablePartialRangeFrom<Int>) -> String {
    let start = index(startIndex, offsetBy: max(0, range.lowerBound))
    return String(self[start...])
  }
}

// MARK: - Optional
extension Optional where Wrapped == String {
  public var isEmpty: Bool {
    if let str = self {
      return str.isEmpty
    }
    return true
  }

  public var isEmail: Bool {
    if let str = self {
      return str.isEmail
    }
    return false
  }

  public var isPhone: Bool {
    if let str = self {
      return str.isPhone
    }
    return false
  }
}
