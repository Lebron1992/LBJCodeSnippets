import Foundation

private class IntervalClass {}

extension Bundle {
  static var current: Bundle {
    Bundle(for: IntervalClass.self)
  }
}
