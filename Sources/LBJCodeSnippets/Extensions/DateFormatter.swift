import Foundation

public extension DateFormatter {
    static func formatter(dateFormat: String, timeZone: TimeZone? = nil) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.timeZone = timeZone
        return formatter
    }
}
