import Foundation

private let jsonEncoder = JSONEncoder()

extension Encodable {
    public var dictionary: [String: Any] {
        let obj = try? JSONSerialization.jsonObject(with: jsonEncoder.encode(self))
        return obj as? [String: Any] ?? [:]
    }
}
