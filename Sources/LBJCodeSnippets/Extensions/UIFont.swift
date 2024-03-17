import UIKit

public extension UIFont {
  class func roundedSystemFont(ofSize size: CGFloat, weight: UIFont.Weight) -> UIFont {
    let font = UIFont.systemFont(ofSize: size, weight: weight)
    if let descriptor = font.fontDescriptor.withDesign(.rounded) {
      return UIFont(descriptor: descriptor, size: size)
    }
    return font
  }
}
