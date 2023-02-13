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

    public func roundCorners(_ corners: CACornerMask, radius: CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = corners
    }

    public func roundCorners(_ corners: UIRectCorner = .allCorners, radius: CGFloat) {
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
