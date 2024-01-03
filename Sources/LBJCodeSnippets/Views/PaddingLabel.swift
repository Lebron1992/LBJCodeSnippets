import UIKit

open class PaddingLabel: UILabel {

  open var contentInset: UIEdgeInsets

  public init(frame: CGRect, contentInset: UIEdgeInsets) {
    self.contentInset = contentInset
    super.init(frame: frame)
  }

  public required init?(coder aDecoder: NSCoder) {
    contentInset = .zero
    super.init(coder: aDecoder)
  }

  open override var bounds: CGRect {
    didSet {
      // ensures this works within stack views if multi-line
      preferredMaxLayoutWidth = bounds.width - (contentInset.left + contentInset.right)
    }
  }

  open override func drawText(in rect: CGRect) {
    super.drawText(in: rect.inset(by: contentInset))
  }

  open override var intrinsicContentSize: CGSize {
    var contentSize = super.intrinsicContentSize
    contentSize.height += contentInset.top + contentInset.bottom
    contentSize.width += contentInset.left + contentInset.right
    return contentSize
  }
}
