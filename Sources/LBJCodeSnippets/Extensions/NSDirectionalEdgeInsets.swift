import UIKit

extension NSDirectionalEdgeInsets {
  static let zero: NSDirectionalEdgeInsets = .init(all: 0)

  public init(horizontal: CGFloat = 0, vertical: CGFloat = 0) {
    self.init(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
  }

  public init(all: CGFloat) {
    self.init(top: all, leading: all, bottom: all, trailing: all)
  }
}
