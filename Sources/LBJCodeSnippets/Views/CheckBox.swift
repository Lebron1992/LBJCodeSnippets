import UIKit

public final class CheckBox: UIButton {
  public var stateObserver: ((Bool) -> Void)?

  public var checkedImage = UIImage(named: "checkbox-checked")?.withRenderingMode(.alwaysOriginal)
  public var uncheckedImage = UIImage(named: "checkbox-unchecked")?.withRenderingMode(.alwaysOriginal)
  public var allowDeselection = true

  public var isChecked: Bool = false {
    didSet {
      setImage(isChecked ? checkedImage : uncheckedImage, for: .normal)
    }
  }

  public override func awakeFromNib() {
    super.awakeFromNib()
    commonInit()
  }

  public override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }

  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }

  private func commonInit() {
    addTarget(self, action: #selector(buttonClicked(sender:)), for: .touchUpInside)
    isChecked = false
  }

  @objc
  private func buttonClicked(sender: UIButton) {
    if !allowDeselection && isChecked {
      return
    }
    isChecked.toggle()
    stateObserver?(isChecked)
  }
}
