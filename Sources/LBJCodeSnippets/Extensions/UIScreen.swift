import UIKit

extension UIScreen {
  public static var width: CGFloat {
    return UIScreen.main.bounds.width
  }

  public static var height: CGFloat {
    return UIScreen.main.bounds.height
  }

  public static var safeAreaInsets: UIEdgeInsets {
    return UIApplication.shared.keyWindow?.safeAreaInsets ?? .zero
  }
}
