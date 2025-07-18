import UIKit

public extension UIDevice {
    /// Returns a string likes `iPhone 12,3`
    static let modelIdentifier: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }()

  static var isPad: Bool {
    UIDevice.current.userInterfaceIdiom == .pad
  }
}
