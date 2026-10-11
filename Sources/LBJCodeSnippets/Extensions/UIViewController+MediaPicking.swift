import MobileCoreServices
import UIKit

extension UIViewController {
  @objc
  open func didPickEditedImage(_ image: UIImage) { }

  @objc
  open func didPickOriginalImage(_ image: UIImage) { }

  @objc
  open func didPickVideo(_ video: URL) { }

  @objc
  open func imagePickerDidCancel(_ picker: UIImagePickerController) { }
}

extension UIViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
  public enum MediaType {
    case image
    case video
    case any

    public var typeStrings: [String] {
      switch self {
      case .image: return [kUTTypeImage as String]
      case .video: return [kUTTypeVideo as String]
      case .any: return [kUTTypeImage as String, kUTTypeVideo as String]
      }
    }
  }

  public func presentMediaOptions(
    withTitle title: String? = nil,
    libraryActionTitle: String = "Choose from library",
    cameraActionTitle: String = "Take photo",
    cancelActionTitle: String = "Cancel",
    mediaType: MediaType = .image,
    allowsEditing: Bool = true,
    delegate: (UIImagePickerControllerDelegate & UINavigationControllerDelegate)? = nil
  ) {
    guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
      presentImagePickerController(
        with: .photoLibrary,
        mediaTypes: mediaType.typeStrings,
        allowsEditing: allowsEditing,
        delegate: delegate
      )
      return
    }

    // iOS 26+ presents `.actionSheet` as a popover (no animation, cancel hidden).
    // Use `.alert` so cancel remains visible and presentation animates normally.
    let preferredStyle: UIAlertController.Style
    if #available(iOS 26, *) {
      preferredStyle = .alert
    } else {
      preferredStyle = .actionSheet
    }

    let optionMenu = UIAlertController(
      title: title,
      message: preferredStyle == .alert ? nil : "",
      preferredStyle: preferredStyle
    )

    if preferredStyle == .actionSheet {
      optionMenu.popoverPresentationController?.sourceView = view
      optionMenu.popoverPresentationController?.sourceRect = CGRect(
        x: view.bounds.midX,
        y: view.bounds.midY,
        width: 0,
        height: 0
      )
      optionMenu.popoverPresentationController?.permittedArrowDirections = []
    }

    let libraryAction = UIAlertAction(
      title: libraryActionTitle,
      style: .default,
      handler: { (_) in
        self.presentImagePickerController(
          with: .photoLibrary,
          mediaTypes: mediaType.typeStrings,
          allowsEditing: allowsEditing,
          delegate: delegate
        )
      }
    )
    let cameraAction = UIAlertAction(
      title: cameraActionTitle,
      style: .default,
      handler: { (_) in
        self.presentImagePickerController(
          with: .camera,
          mediaTypes: mediaType.typeStrings,
          allowsEditing: allowsEditing,
          delegate: delegate
        )
      }
    )
    let cancelAction = UIAlertAction(title: cancelActionTitle, style: .cancel, handler: nil)
    optionMenu.addAction(libraryAction)
    optionMenu.addAction(cameraAction)
    optionMenu.addAction(cancelAction)
    present(optionMenu, animated: true, completion: nil)
  }

  public func imagePickerController(
    _ picker: UIImagePickerController,
    didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
  ) {
    guard let type = info[.mediaType] as? String else {
      return
    }

    if type == kUTTypeImage as String {

      if let originalImage = info[.originalImage] as? UIImage {
        didPickOriginalImage(originalImage)
      }
      if let editedImage = info[.editedImage] as? UIImage {
        didPickEditedImage(editedImage)
      }

    } else if type == kUTTypeMovie as String ||
                type == kUTTypeVideo as String,
              let pickedVideoPath = info[.mediaURL] as? URL {

      didPickVideo(pickedVideoPath)
    }
  }

  public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    imagePickerDidCancel(picker)
  }

  public func presentImagePickerController(
    with sourceType: UIImagePickerController.SourceType,
    mediaTypes: [String],
    allowsEditing: Bool = true,
    delegate: (UIImagePickerControllerDelegate & UINavigationControllerDelegate)? = nil
  ) {
    let picker = UIImagePickerController()
    picker.delegate = delegate ?? self
    picker.allowsEditing = allowsEditing
    picker.sourceType = sourceType
    picker.mediaTypes = mediaTypes
    present(picker, animated: true, completion: nil)
  }
}
