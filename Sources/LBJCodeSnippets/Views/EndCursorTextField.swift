import UIKit

/// Forces caret to the end on tap / first responder.
open class EndCursorTextField: UITextField {

  public override func closestPosition(to point: CGPoint) -> UITextPosition? {
    endOfDocument
  }

  public override func closestPosition(to point: CGPoint, within range: UITextRange) -> UITextPosition? {
    endOfDocument
  }

  public override func becomeFirstResponder() -> Bool {
    let became = super.becomeFirstResponder()
    if became {
      selectedTextRange = textRange(from: endOfDocument, to: endOfDocument)
    }
    return became
  }
}
