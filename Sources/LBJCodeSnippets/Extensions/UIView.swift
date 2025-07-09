import UIKit

extension UIView {

    // MARK: - Constraints

    public func fillSuperview(useSafeArea: Bool = true) {
        translatesAutoresizingMaskIntoConstraints = false
        let superview = self.superview!
        if #available(iOS 11.0, *), useSafeArea {
            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor),
                bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor),
                leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor),
                trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: superview.topAnchor),
                bottomAnchor.constraint(equalTo: superview.bottomAnchor),
                leadingAnchor.constraint(equalTo: superview.leadingAnchor),
                trailingAnchor.constraint(equalTo: superview.trailingAnchor)
            ])
        }
    }

    public func constraintEdges(to superview: UIView, useSafeArea: Bool = true) {
        translatesAutoresizingMaskIntoConstraints = false

        if self.superview == nil {
            superview.addSubview(self)
        }

        if #available(iOS 11.0, *), useSafeArea {
            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor),
                bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor),
                leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor),
                trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: superview.topAnchor),
                bottomAnchor.constraint(equalTo: superview.bottomAnchor),
                leadingAnchor.constraint(equalTo: superview.leadingAnchor),
                trailingAnchor.constraint(equalTo: superview.trailingAnchor)
            ])
        }
    }

    public func setSubviewsTranslatingMasksToConstraints(to value: Bool, except exceptedViews: [UIView] = []) {
        subviews.forEach { subview in
            if exceptedViews.contains(subview) {
                return
            }
            subview.translatesAutoresizingMaskIntoConstraints = value
            if subview.subviews.count > 0 {
                subview.setSubviewsTranslatingMasksToConstraints(to: value, except: exceptedViews)
            }
        }
    }

    // MARK: - Corner

    public func roundCorners(_ corners: CACornerMask? = nil, radius: CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = radius
        if let corners = corners {
            layer.maskedCorners = corners
        }
    }
}

public extension UIView {

  func disableDragAndDrop() {
    interactions.removeAll { $0 is UIDragInteraction || $0 is UIDropInteraction }
  }
}

public extension UIView {
    var parentViewController: UIViewController? {
        // Starts from next (As we know self is not a UIViewController).
        var parentResponder: UIResponder? = self.next
        while parentResponder != nil {
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
            parentResponder = parentResponder?.next
        }
        return nil
    }
}
