import UIKit

public extension UIAction {
  static func share(title: String = "分享", image: UIImage? = .init(systemName: "square.and.arrow.up"), handler: @escaping UIActionHandler) -> UIAction {
    UIAction(
      title: title,
      image: image,
      handler: handler
    )
  }

  static func edit(title: String = "编辑", image: UIImage? = .init(systemName: "applepencil.gen2"), handler: @escaping UIActionHandler) -> UIAction {
    UIAction(
      title: title,
      image: image,
      handler: handler
    )
  }
  static func delete(title: String = "删除", image: UIImage? = .init(systemName: "trash"), handler: @escaping UIActionHandler) -> UIAction {
    UIAction(
      title: title,
      image: image,
      attributes: .destructive,
      handler: handler
    )
  }
}
