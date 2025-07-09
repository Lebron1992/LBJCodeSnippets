import Foundation

extension Date {
  public var startOfMonth: Date {
    Calendar.current.date(
      from: Calendar.current.dateComponents(
        [.year, .month],
        from: Calendar.current.startOfDay(for: self)
      )
    )!
  }

  public func isEarlierThan(_ anotherDate: Date) -> Bool {
    self < anotherDate
  }

  public func daysInBetweenDate(_ date: Date) -> Double {
    var diff = self.timeIntervalSince1970 - date.timeIntervalSince1970
    diff = fabs(diff/86400)
    return diff
  }

  public func components(from date: Date) -> (years: Int, months: Int, days: Int) {
    let components = Calendar.current.dateComponents(
      [.year, .month, .day],
      from: date,
      to: self
    )
    return (components.year ?? 0, components.month ?? 0, components.day ?? 0)
  }

  public func monthComponents(from date: Date) -> Int? {
    let components = Calendar.current.dateComponents(
      [.month],
      from: date,
      to: self
    )
    return components.month
  }

  public func components(_ components: Set<Calendar.Component>) -> DateComponents {
    Calendar.current.dateComponents(components, from: self)
  }

  public var weekday: Int {
    let day = Calendar.current.component(.weekday, from: self)
    if day == 1 {
      return 7
    }
    return day - 1
  }

  public func isEqual(
    to date: Date,
    toGranularity component: Calendar.Component,
    in calendar: Calendar = .current
  ) -> Bool {
    calendar.isDate(self, equalTo: date, toGranularity: component)
  }

  public func isInSameYear(as date: Date, in calendar: Calendar = .current) -> Bool {
    isEqual(to: date, toGranularity: .year, in: calendar)
  }
  public func isInSameMonth(as date: Date, in calendar: Calendar = .current) -> Bool {
    isEqual(to: date, toGranularity: .month, in: calendar)
  }
  public func isInSameWeek(as date: Date, in calendar: Calendar = .current) -> Bool {
    isEqual(to: date, toGranularity: .weekOfYear, in: calendar)
  }
  public func isInSameDay(as date: Date, in calendar: Calendar = .current) -> Bool {
    calendar.isDate(self, inSameDayAs: date)
  }

  public var isInThisYear: Bool {
    isInSameYear(as: Date())
  }
  public var isInThisMonth: Bool
  { isInSameMonth(as: Date())
  }
  public var isInThisWeek: Bool {
    isInSameWeek(as: Date())
  }

  public var isInYesterday: Bool {
    Calendar.current.isDateInYesterday(self)
  }
  public var isInToday: Bool {
    Calendar.current.isDateInToday(self)
  }
  public var isInTomorrow: Bool {
    Calendar.current.isDateInTomorrow(self)
  }

  public var isInTheFuture: Bool {
    self > Date()
  }
  public var isInThePast: Bool {
    self < Date()
  }
}
