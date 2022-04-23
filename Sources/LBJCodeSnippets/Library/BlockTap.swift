import UIKit

/// Make sure you use  "[weak self] (gesture) in" if you are using the keyword self inside the closure or there might be a memory leak
public class BlockTap: UITapGestureRecognizer {
    private var tapAction: ((UITapGestureRecognizer) -> Void)?

    override init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
    }

    public convenience init (
        tapCount: Int = 1,
        fingerCount: Int = 1,
        action: ((UITapGestureRecognizer) -> Void)?) {
            self.init()
            self.numberOfTapsRequired = tapCount

            #if os(iOS)

            self.numberOfTouchesRequired = fingerCount

            #endif

            self.tapAction = action
            self.addTarget(self, action: #selector(BlockTap.didTap(_:)))
    }

    @objc public func didTap(_ tap: UITapGestureRecognizer) {
        tapAction?(tap)
    }
}

extension UIView {
    public func addTapGesture(tapNumber: Int = 1, action: ((UITapGestureRecognizer) -> Void)?) {
        let tap = BlockTap(tapCount: tapNumber, fingerCount: 1, action: action)
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }
}
