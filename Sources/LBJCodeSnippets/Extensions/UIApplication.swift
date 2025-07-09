import UIKit

public extension UIApplication {
  var foregroundActiveScene: UIWindowScene? {
    connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene
  }
}
