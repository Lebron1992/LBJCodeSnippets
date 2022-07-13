import UIKit

extension UIColor {
  public static func RGB(
    _ r: CGFloat,
    _ g: CGFloat,
    _ b: CGFloat,
    _ alpha: CGFloat = 1
  ) -> UIColor {
    UIColor(
      displayP3Red: r / 255,
      green: g / 255,
      blue: b / 255,
      alpha: alpha
    )
  }

  public static func random() -> UIColor {
    let red: CGFloat = CGFloat(drand48())
    let green: CGFloat = CGFloat(drand48())
    let blue: CGFloat = CGFloat(drand48())
    return UIColor(
      red: red,
      green: green,
      blue: blue,
      alpha: 1.0
    )
  }

  public static func hex(_ hexStr: String) -> UIColor {
    var cString: String = hexStr.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if cString.hasPrefix("#") {
      cString.remove(at: cString.startIndex)
    }

    if cString.count != 6 {
      fatalError("hexStr must be similar to `#2F2F2F` or `2F2F2F`")
    }

    var rgbValue: UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)

    return UIColor(
      red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
      alpha: CGFloat(1.0)
    )
  }

  public var hexString:String? {
    if let components = self.cgColor.components {
      let r = components[0]
      let g = components[1]
      let b = components[2]
      return  String(format: "#%02x%02x%02x", (Int)(r * 255), (Int)(g * 255), (Int)(b * 255))
    }
    return nil
  }

  public func toImage() -> UIImage? {
    let rect = CGRect(x: 0, y: 0, width: 1, height: 1)

    UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
    defer { UIGraphicsEndImageContext() }

    setFill()
    UIRectFill(rect)

    let image = UIGraphicsGetImageFromCurrentImageContext()
    return image
  }
}
