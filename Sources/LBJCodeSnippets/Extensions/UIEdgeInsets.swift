import UIKit

extension UIEdgeInsets {
  public init(horizontal: CGFloat = 0, vertical: CGFloat = 0) {
    self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
  }

  public init(all: CGFloat) {
    self.init(top: all, left: all, bottom: all, right: all)
  }

  public init(top: CGFloat = 0, bottom: CGFloat = 0, left: CGFloat = 0, right: CGFloat = 0) {
    self.init(top: top, left: left, bottom: bottom, right: right)
  }
}
