import UIKit

public final class PaddingLabel: UILabel {

  public var contentInset: UIEdgeInsets

  public required init(frame: CGRect, contentInset: UIEdgeInsets) {
    self.contentInset = contentInset
    super.init(frame: frame)
  }

  public required init?(coder aDecoder: NSCoder) {
    contentInset = .zero
    super.init(coder: aDecoder)
  }

  public override func drawText(in rect: CGRect) {
    super.drawText(in: rect.inset(by: contentInset))
  }

  public override var intrinsicContentSize: CGSize {
    var contentSize = super.intrinsicContentSize
    contentSize.height += contentInset.top + contentInset.bottom
    contentSize.width += contentInset.left + contentInset.right
    return contentSize
  }
}
