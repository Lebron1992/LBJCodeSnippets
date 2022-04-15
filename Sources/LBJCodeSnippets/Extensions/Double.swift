import Foundation

// MARK: - Round
extension Double {
  public func removeZerosFromEnd() -> String {
    let formatter = NumberFormatter()
    let number = NSNumber(value: self)
    formatter.minimumFractionDigits = 0
    formatter.maximumFractionDigits = 16
    return String(formatter.string(from: number) ?? "")
  }

  public func rounded(
    toPlaces places: Int,
    _ roundingRule: FloatingPointRoundingRule = .toNearestOrAwayFromZero
  ) -> Double {
    let divisor = pow(10.0, Double(places))
    return (self * divisor).rounded(roundingRule) / divisor
  }

  public func round(nearest: Double) -> Double {
    let n = 1 / nearest
    let numberToRound = self * n
    return numberToRound.rounded() / n
  }
}

// MARK: - Degree
extension Double {
  public func toDegree() -> Double {
    self / .pi * 180
  }

  public func toRadius() -> Double {
    self / 180 * .pi
  }

  public var sign: Double {
    self > 0 ? 1 : -1
  }
}
