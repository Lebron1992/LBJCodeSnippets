import UIKit

extension UIViewController {
  public func presentDialog(content: UIView, horizontalMargin: CGFloat = 20) {
    let dialog = DialogContainerViewController.instantiate(
      content: content,
      horizontalMargin: horizontalMargin
    )
    dialog.modalPresentationStyle = .overCurrentContext
    dialog.modalTransitionStyle = .crossDissolve
    present(dialog, animated: true)
  }
}

final class DialogContainerViewController: UIViewController {

  static func instantiate(content: UIView, horizontalMargin: CGFloat = 20) -> DialogContainerViewController {
    let vc = Storyboard.Dialog.instantiate(DialogContainerViewController.self)
    vc.content = content
    vc.horizontalMargin = horizontalMargin
    return vc
  }

  var content: UIView!
  var horizontalMargin: CGFloat = 20

  @IBOutlet weak var rootContainer: UIView!
  @IBOutlet weak var closeButton: UIButton!
  @IBOutlet weak var contentContainer: UIView!
  @IBOutlet weak var contentLeadingConstraint: NSLayoutConstraint!

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    configContent()
  }

  func configContent() {
    rootContainer.layer.cornerRadius = 8
    rootContainer.clipsToBounds = true

    closeButton.setTitle("", for: .normal)
    closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)

    contentLeadingConstraint.constant = horizontalMargin

    contentContainer.addSubview(content)
    content.translatesAutoresizingMaskIntoConstraints = false
    content.constraintEdges(to: contentContainer)
  }

  @objc private func closeButtonTapped() {
    dismiss(animated: true)
  }
}
