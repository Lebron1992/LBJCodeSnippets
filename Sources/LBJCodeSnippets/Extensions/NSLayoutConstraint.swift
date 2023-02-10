import UIKit

extension NSLayoutConstraint {

    func clone(withMultiplier multiplier: CGFloat) -> NSLayoutConstraint {
        NSLayoutConstraint.deactivate([self])

        let newConstraint = NSLayoutConstraint(
            item: firstItem as Any,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant)

        newConstraint.priority = priority
        newConstraint.shouldBeArchived = shouldBeArchived
        newConstraint.identifier = identifier

        NSLayoutConstraint.activate([newConstraint])
        return newConstraint
    }
}
