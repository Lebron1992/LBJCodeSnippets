
import UIKit

public class UICollectionViewLeftAlignedLayout: UICollectionViewFlowLayout {

  public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    guard let superAttrs = super.layoutAttributesForElements(in: rect) else { return nil }
    let newAttrs = superAttrs.enumerated().map { index, attrs in
      if index == 0 || superAttrs[index - 1].frame.origin.y != attrs.frame.origin.y {
        attrs.frame.origin.x = sectionInset.left
      } else {
        let prevAttrs = superAttrs[index - 1]
        let prevTrailing = prevAttrs.frame.origin.x + prevAttrs.frame.width
        attrs.frame.origin.x = prevTrailing + minimumInteritemSpacing
      }
      return attrs
    }
    return newAttrs
  }
}
