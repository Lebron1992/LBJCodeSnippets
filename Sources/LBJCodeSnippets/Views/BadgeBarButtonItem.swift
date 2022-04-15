import UIKit

public final class BadgedButtonItem: UIBarButtonItem {

  private var badgeValue: Int? {
    didSet {
      if let value = badgeValue,
         value > 0 {
        badgeLabel.isHidden = false
        badgeLabel.text = "\(value)"
      } else {
        badgeLabel.isHidden = true
      }
    }
  }

  public var tapAction: (() -> Void)?

  private lazy var badgeLabel: UILabel = {
    let badgeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
    badgeLabel.clipsToBounds = true
    badgeLabel.layer.cornerRadius = 8
    badgeLabel.backgroundColor = .red
    badgeLabel.font = .systemFont(ofSize: 10, weight: .semibold)
    badgeLabel.textColor = .white
    badgeLabel.textAlignment = .center
    badgeLabel.isHidden = true
    badgeLabel.minimumScaleFactor = 0.1
    badgeLabel.adjustsFontSizeToFitWidth = true
    return badgeLabel
  }()

  private lazy var labelContainerView: UIView = {
    let view = UIView(frame: CGRect(x: 20, y: 0, width: 16, height: 16))
    view.backgroundColor = .clear
    view.layer.shadowColor = UIColor.white.withAlphaComponent(0.25).cgColor
    view.layer.shadowOpacity = 1
    view.layer.shadowRadius = 4
    view.layer.shadowOffset = CGSize(width: 0, height: 1)
    return view
  }()

  private lazy var actionButton: UIButton = {
    let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    button.adjustsImageWhenHighlighted = false
    button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    return button
  }()

  override init() {
    super.init()
    setup()
  }

  init(with image: UIImage?) {
    super.init()
    setup(image: image)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  public override var tintColor: UIColor? {
    didSet {
      actionButton.tintColor = tintColor
    }
  }

  private func setup(image: UIImage? = nil) {
    labelContainerView.addSubview(badgeLabel)
    actionButton.setImage(image, for: .normal)
    actionButton.addSubview(labelContainerView)
    self.customView = actionButton
  }

  @objc func actionButtonTapped() {
    tapAction?()
  }

  public func setBadge(with value: Int?) {
    self.badgeValue = value
  }
}
