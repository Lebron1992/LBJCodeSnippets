import Foundation

extension Data {
  public var hexString: String {
    map { String(format: "%02.2hhx", $0) }.joined()
  }
}
