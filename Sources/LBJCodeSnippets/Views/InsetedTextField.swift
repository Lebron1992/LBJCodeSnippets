import UIKit

class InsetedTextField: UITextField {

    var contentInsets: UIEdgeInsets = .init(all: 8) {
        didSet { layoutIfNeeded() }
    }

    override func borderRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.borderRect(forBounds: bounds)
        return rect.inset(by: contentInsets)
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: contentInsets)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: contentInsets)
    }

    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.leftViewRect(forBounds: bounds)
        return rect.inset(by: .init(top: 0, left: contentInsets.left, bottom: 0, right: -contentInsets.right))
    }

    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.rightViewRect(forBounds: bounds)
        return rect.inset(by: .init(top: 0, left: -contentInsets.left, bottom: 0, right: contentInsets.right))
    }
}
