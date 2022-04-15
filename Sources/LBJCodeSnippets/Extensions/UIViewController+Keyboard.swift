import UIKit

extension UIViewController {
  public func hideKeyboardWhenTappedAround(cancelTouches: Bool = false) {
    let tap = UITapGestureRecognizer(
      target: self,
      action: #selector(viewDidTapped)
    )
    tap.cancelsTouchesInView = cancelTouches
    view.addGestureRecognizer(tap)
  }

  @objc
  private func viewDidTapped() {
    view.endEditing(true)
  }
}
