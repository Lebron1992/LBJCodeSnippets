import UIKit

extension UIEdgeInsets {
    public init(horizontal: CGFloat, vertical: CGFloat) {
        self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }

    public init(all: CGFloat) {
        self.init(top: all, left: all, bottom: all, right: all)
    }
}
