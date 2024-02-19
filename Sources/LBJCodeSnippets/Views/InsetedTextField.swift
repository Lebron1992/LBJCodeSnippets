import UIKit

open class InsetedTextField: UITextField {

  public var contentInsets: UIEdgeInsets {
    didSet { layoutIfNeeded() }
  }

  public init(frame: CGRect, contentInsets: UIEdgeInsets = .init(all: 8)) {
    self.contentInsets = contentInsets
    super.init(frame: frame)
  }
  
  required public init?(coder: NSCoder) {
    self.contentInsets = .init(all: 8)
    super.init(coder: coder)
  }

  public override func borderRect(forBounds bounds: CGRect) -> CGRect {
    let rect = super.borderRect(forBounds: bounds)
    return rect.inset(by: contentInsets)
  }

  public override func textRect(forBounds bounds: CGRect) -> CGRect {
    let rect = super.textRect(forBounds: bounds)
    return rect.inset(by: contentInsets)
  }

  public override func editingRect(forBounds bounds: CGRect) -> CGRect {
    let rect = super.editingRect(forBounds: bounds)
    return rect.inset(by: contentInsets)
  }

  public override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
    let rect = super.leftViewRect(forBounds: bounds)
    return rect.inset(by: .init(top: 0, left: contentInsets.left, bottom: 0, right: -contentInsets.right))
  }

  public override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
    let rect = super.rightViewRect(forBounds: bounds)
    return rect.inset(by: .init(top: 0, left: -contentInsets.left, bottom: 0, right: contentInsets.right))
  }
}
