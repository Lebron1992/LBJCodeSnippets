import UIKit

public class BlockLongPress: UILongPressGestureRecognizer {
  private var longPressAction: ((UILongPressGestureRecognizer) -> Void)?

  override init(target: Any?, action: Selector?) {
    super.init(target: target, action: action)
  }

  public convenience init (
    minimumPressDuration: CFTimeInterval = 0.5,
    action: ((UILongPressGestureRecognizer) -> Void)?) {
      self.init()
      self.minimumPressDuration = minimumPressDuration
      self.longPressAction = action
      self.addTarget(self, action: #selector(BlockLongPress.didLongPress(_:)))
    }

  @objc public func didLongPress(_ longPress: UILongPressGestureRecognizer) {
    longPressAction?(longPress)
  }
}

extension UIView {
  public func addLongPressGesture(minimumPressDuration: CFTimeInterval = 0.5, action: ((UILongPressGestureRecognizer) -> Void)?) {
    let longPress = BlockLongPress(minimumPressDuration: minimumPressDuration, action: action)
    addGestureRecognizer(longPress)
    isUserInteractionEnabled = true
  }
}
