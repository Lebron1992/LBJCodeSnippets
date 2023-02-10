import UIKit

public class InsetedTextField: UITextField {

    public var contentInsets: UIEdgeInsets = .init(all: 8) {
        didSet { layoutIfNeeded() }
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
