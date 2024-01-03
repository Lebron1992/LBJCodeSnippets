import Foundation

extension Int {
  // Reference: https://gist.github.com/gbitaudeau/daa4d6dc46517b450965e9c7e13706a3

  private typealias Abbrevation = (threshold: Double, divisor: Double, suffix: String)

  public func abbrevation(maximumFractionDigits: Int = 2) -> String? {
    let abbreviations: [Abbrevation] = [
      (0, 1, ""),
      (1000.0, 1000.0, "K"),
      (100_000.0, 1_000_000.0, "M"),
      (100_000_000.0, 1_000_000_000.0, "B")
    ]

    guard let abbreviation = abbreviations.last(where: { Double(abs(self)) >= $0.threshold }) else {
      return nil
    }

    let numFormatter: NumberFormatter = {
      let formatter = NumberFormatter()
      formatter.positiveSuffix = abbreviation.suffix
      formatter.negativeSuffix = abbreviation.suffix
      formatter.allowsFloats = true
      formatter.minimumIntegerDigits = 1
      formatter.minimumFractionDigits = 0
      formatter.maximumFractionDigits = maximumFractionDigits
      return formatter
    }()

    let value = Double(self) / abbreviation.divisor
    return numFormatter.string(from: .init(value: value))
  }

  public var secondsToHoursMinutesSecondsDisplay: String {
    let hours = self / 3600
    let mins = (self % 3600) / 60
    let seconds = (self % 3600) % 60
    let secondsStr = seconds > 9 ? "\(seconds)" : "0\(seconds)"
    if hours == 0 {
      return "\(mins):\(secondsStr)"
    }
    return "\(hours):\(mins):\(secondsStr)"
  }
}
